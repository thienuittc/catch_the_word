import 'dart:convert';

import 'package:catch_the_word/core/firebase/interfaces/ifirebase_auth.dart';
import 'package:catch_the_word/core/global/router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/global/global_data.dart';
import '../../../core/global/locator.dart';
import '../../../core/model_ui/user_ui_model.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    User? _firebaseAuth = FirebaseAuth.instance.currentUser;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_firebaseAuth == null) {
        Get.offNamed(MyRouter.login);
      } else {
        _asyncMethod(_firebaseAuth);
      }
    });

    super.initState();
  }

  _asyncMethod(User firebaseUser) async {
    var ifirebaseAuth = locator<IFirebaseAuthService>();
    await ifirebaseAuth.getAndSetCurrenUser(firebaseUser);
    Get.toNamed(MyRouter.chatList);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
