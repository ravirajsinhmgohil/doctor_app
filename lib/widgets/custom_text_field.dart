import 'package:doctor_app/utils/color_helper.dart';
import 'package:doctor_app/utils/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyBoardType;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController controller;
  const CustomTextField({
    this.validator,
    this.suffixIcon,
    required this.controller,
    required this.hintText,
    super.key,
    this.keyBoardType,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyBoardType,
      validator: validator,
      cursorColor: AppColor.theme,
      controller: controller,
      style: TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
      ),
      obscureText: obscureText,
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.theme),
        ),
        hintText: hintText,
        hintStyle: TextStyleHelper.hintText,
        suffixIcon: suffixIcon,
        focusColor: AppColor.theme,
      ),
    );
  }
}
