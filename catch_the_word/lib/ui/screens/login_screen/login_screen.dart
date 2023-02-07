import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/firebase/interfaces/ifirebase_auth.dart';
import '../../../core/global/global_data.dart';
import '../../../core/global/locator.dart';
import '../../../core/global/router.dart';
import '../../../core/model_ui/user_ui_model.dart';
import '../../base_screen/base_screen.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_textfield.dart';

class LoginScreen extends BaseScreen {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build() {
    return _Login();
  }
}

class _Login extends StatefulWidget {
  _Login({Key? key}) : super(key: key);

  @override
  State<_Login> createState() => __LoginState();
}

class __LoginState extends State<_Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _checkBox = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login Account",
                            style: TextStyle(fontSize: 28.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Hello. welcome back to our account",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      // Container(
                      //   height: 100.r,
                      //   width: 100.r,
                      //   child: Lottie.asset(
                      //       'assets/lottie_files/122255-spooky-pumpkin.json'),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    lable: "Email",
                    prefixIcon: Icon(Icons.mail),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    obscureText: true,
                    enabled: true,
                    controller: passwordController,
                    lable: "Password",
                    prefixIcon: Icon(Icons.lock),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                              value: _checkBox,
                              onChanged: (value) {
                                setState(() {
                                  _checkBox = value!;
                                });
                              }),
                          Text(
                            "Remember me",
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Forgot password?",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomButton(
                    text: "Login",
                    onPressed: () async {
                      await locator<IFirebaseAuthService>().signIn(
                          emailController.text, passwordController.text);
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                      child: Text(
                    "Or",
                    style: TextStyle(
                        fontSize: 16.h,
                        color: Colors.grey,
                        fontWeight: FontWeight.w100),
                  )),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomButton(
                    color: Colors.amber,
                    text: "Guest Login",
                    onPressed: () async {
                      await locator<IFirebaseAuthService>().signInAnonymously();
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                      child: Text(
                    "Or",
                    style: TextStyle(
                        fontSize: 16.h,
                        color: Colors.grey,
                        fontWeight: FontWeight.w100),
                  )),
                  SizedBox(
                    height: 10.h,
                  ),
                  SignInButton(
                    Buttons.Google,
                    onPressed: () async {
                      await locator<IFirebaseAuthService>().signInWithGoogle();
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an Account ? "),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(MyRouter.signUp);
                        },
                        child: Text(
                          "Create new account",
                          style: TextStyle(color: Colors.blue, fontSize: 16.sp),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
