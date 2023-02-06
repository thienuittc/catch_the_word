import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/firebase/interfaces/ifirebase_auth.dart';
import '../../../core/global/locator.dart';
import '../../base_screen/base_screen.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_textfield.dart';

class SignUpScreen extends BaseScreen {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build() {
    return const _SignUp();
  }
}

class _SignUp extends StatefulWidget {
  const _SignUp({Key? key}) : super(key: key);

  @override
  State<_SignUp> createState() => __SignUpState();
}

class __SignUpState extends State<_SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController birthController = TextEditingController();

  bool _checkBox = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    phoneNumberController.dispose();
    nameController.dispose();
    birthController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          "Create new account",
                          style: TextStyle(fontSize: 28.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
                CustomTextField(
                  controller: nameController,
                  lable: "Name",
                  prefixIcon: Icon(Icons.person),
                ),
                SizedBox(
                  height: 10.h,
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
                  keyboardType: TextInputType.phone,
                  controller: phoneNumberController,
                  lable: "Phone Number",
                  prefixIcon: Icon(Icons.phone),
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  keyboardType: TextInputType.datetime,
                  controller: birthController,
                  lable: "Birthday",
                  prefixIcon: Icon(Icons.calendar_month),
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
                  height: 10.h,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomButton(
                  text: "Create",
                  onPressed: () async {
                    await locator<IFirebaseAuthService>().signUp(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                        phoneNumberController.text,
                        birthController.text);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
