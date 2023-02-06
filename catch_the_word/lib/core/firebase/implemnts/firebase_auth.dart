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
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) async {
      await _createUser(user.user!);
      Get.toNamed(MyRouter.draw);
    }).catchError((onError) {
      Get.snackbar("SignUp failed!", onError);
    });
  }

  @override
  Future<void> signUp(String name, String email, String password,
      String phoneNumber, String birth) async {
    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) async {
      await _createUser(user.user!);
    }).catchError((onError) {
      Get.snackbar("SignUp failed!", onError);
    });
  }

  Future<void> _createUser(User userCredential) async {
    await _firestore.collection('users').doc(userCredential.uid).set({
      'name': userCredential.displayName,
      'photoUrl': userCredential.photoURL,
      'uid': userCredential.uid,
      'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
    }).then((value) async {
      Get.toNamed(MyRouter.login);
      var prefs = await SharedPreferences.getInstance();
      var user = UserModelUI(
        id: userCredential.uid,
        name: userCredential.displayName ?? "",
        photoUrl: userCredential.photoURL??"",
        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      );
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
  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    var userCredential =
        (await FirebaseAuth.instance.signInWithCredential(credential)).user;

    if (userCredential != null) {
      final QuerySnapshot result = await _firestore
          .collection('users')
          .where('uid', isEqualTo: userCredential.uid)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        // Writing data to server because here is a new user
        _firestore.collection('users').doc(userCredential.uid).set({
          'name': userCredential.displayName,
          'photoUrl': userCredential.photoURL,
          'uid': userCredential.uid,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
        });
      }
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
