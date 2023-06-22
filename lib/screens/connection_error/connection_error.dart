import 'package:doctor_app/utils/color_helper.dart';
import 'package:doctor_app/utils/method_helper.dart';
import 'package:doctor_app/utils/strings_helper.dart';
import 'package:doctor_app/utils/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ConnectionErrorScreen extends StatelessWidget with Methods {
  const ConnectionErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.theme,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.h),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.appBackground,
              ),
              height: 15.h,
              width: 15.h,
              child: Icon(
                size: 60.sp,
                Icons.error,
                color: Colors.red.shade200,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.h,
              vertical: 2.h,
            ),
            child: Column(
              children: [
                Text(
                  Strings.connectionLost,
                  style: TextStyleHelper.connectionPageLabel,
                ),
                height(1.h),
                Text(
                  Strings.pleaseCheckYourInternet,
                  textAlign: TextAlign.center,
                  style: TextStyleHelper.connectionPageSubLabel,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
