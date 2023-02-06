import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CrossWord extends StatelessWidget {
  const CrossWord(
      {Key? key,
      required this.isDisabled,
      required this.char,
      required this.onTap})
      : super(key: key);
  final bool isDisabled;
  final String char;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isDisabled,
      replacement: SizedBox(
        height: 50.r,
        width: 50.r,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50.r,
          width: 50.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Color(0xFF3E87FF),
          ),
          child: Center(
            child: Text(
              char,
              style: TextStyle(
                fontSize: 24.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
