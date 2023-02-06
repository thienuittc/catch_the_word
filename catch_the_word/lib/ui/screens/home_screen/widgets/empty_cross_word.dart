import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CrossWordEmpty extends StatelessWidget {
  const CrossWordEmpty({Key? key, required this.char}) : super(key: key);
  final String char;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.r,
      width: 50.r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          width: 3.r,
          color: Color(0xFF3E87FF),
        ),
      ),
      child: Center(
        child: Text(
          char,
          style: TextStyle(
            fontSize: 24.sp,
            color: Color(0xFF3E87FF),
          ),
        ),
      ),
    );
  }
}
