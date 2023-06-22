import 'package:doctor_app/utils/method_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomProfileLabel extends StatelessWidget with Methods {
  final String label;
  const CustomProfileLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        width(0.6.h),
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
