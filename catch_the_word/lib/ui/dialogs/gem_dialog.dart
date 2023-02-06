
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../common_widgets/custom_button.dart';

class GemDialog extends StatelessWidget {
  const GemDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 23.h),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 35.w, right: 35.w),
              height: 240.h,
              width: 335.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  width: 8.r,
                  color: Color(0xFF3E87FF),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Xem quảng cáo cho đến khi kết thúc để kiếm thêm 20 đá quý",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.sp,
                      decoration: TextDecoration.none,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 23.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        fillBackGround: false,
                        text: "Để sau",
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      CustomButton(
                        text: "Xem ngay",
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 46.h,
            width: 182.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(
                width: 3.r,
                color: Color(0xFF3E87FF),
              ),
            ),
            child: Text(
              "Đá quý",
              style: TextStyle(
                fontSize: 24.sp,
                decoration: TextDecoration.none,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
