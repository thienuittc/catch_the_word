import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../global/global_data.dart';
import '../../global/router.dart';
import '../../model_ui/user_ui_model.dart';
import '../interfaces/ifirebase_auth.dart';

class FirebaseAuthService implements IFirebaseAuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;
  @override
  Future<void> signIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Get.toNamed(MyRouter.draw);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Login failed!", e.code);
      print('e.code');
    }
  }

  @override
  Future<void> signUp(String name, String email, String password,
      String phoneNumber, String birth) async {
    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) async {
      await _createUser(user.user!.uid, name, phoneNumber, birth);
    }).catchError((onError) {
      Get.snackbar("SignUp failed!", onError);
    });
  }

  Future<void> _createUser(
      String userId, String name, String? phoneNumber, String birth) async {
    await _firestore.collection("users").add({
      "userId": userId,
      "name": name,
      "phoneNumber": phoneNumber ?? "",
      "birth": birth,
      'createTime': DateTime.now(),
    }).then((value) async {
      Get.toNamed(MyRouter.login);
      var prefs = await SharedPreferences.getInstance();
      var user = UserModelUI(
          id: userId, name: name, phoneNumber: phoneNumber ?? "", birth: birth);
      String userJson = jsonEncode(user.toJson());
      prefs.setString('userData', userJson);
      GlobalData().user = user;
      Get.snackbar("Đăng kí thành công!", "");
    }).catchError((onError) {
      Get.snackbar("SignUp failed!", onError);
    });
    ;
  }

  @override
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return;
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    var ref = await _firestore
        .collection("users")
        .where("userId", isEqualTo: userCredential.user?.uid)
        .get();
    var x = ref.docs.isEmpty;
    //     .then((a) async {
    //   if (a.docs.g ==null)
    //     await _createUser(
    //         userCredential.user!.uid,
    //         userCredential.user!.displayName!,
    //         userCredential.user!.phoneNumber!,
    //         "");
    // });
    if (ref.docs.isEmpty) {
      await _createUser(
          userCredential.user!.uid,
          userCredential.user!.displayName!,
          userCredential.user!.phoneNumber,
          "");
    }
    Get.toNamed(MyRouter.chatList);
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.toNamed(MyRouter.login);
  }

  @override
  Future<void> signInAnonymously() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.");
      Get.toNamed(MyRouter.draw);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }
}
