import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.fillBackGround = true,
    this.color,
  }) : super(key: key);
  final String text;
  final Function() onPressed;
  bool fillBackGround;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: 16.r,
        ),
        height: 44.h,
        decoration: BoxDecoration(
          color: fillBackGround ?color?? Color(0xFF3E87FF) : Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            width: 3.r,
            color:color?? Color(0xFF3E87FF),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 3.h), // changes position of shadow
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 22.sp,
            color: fillBackGround ? Colors.white : Colors.black,
            fontWeight: FontWeight.w300,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
