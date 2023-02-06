import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.lable,
    required this.prefixIcon,
    this.enabled,
    this.keyboardType,
    this.obscureText = false,
  }) : super(key: key);
  final TextEditingController controller;
  final String lable;
  final Icon prefixIcon;
  final bool obscureText;
  final bool? enabled;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: lable,
        hintStyle: TextStyle(
          fontSize: 18.sp,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            borderSide: BorderSide(
              color: Colors.white10,
              width: 3.r,
            )),
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
      ),
    );
  }
}
