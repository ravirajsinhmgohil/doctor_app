import 'package:doctor_app/utils/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TextStyleHelper {
  //for auth screen title
  static TextStyle authScreenTitle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w800,
  );
  //for auth screen label
  static TextStyle authScreenLabel = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.bold,
  );
  //for google login button text
  static TextStyle googleLoginText = TextStyle(
      color: AppColor.themeGreen, fontSize: 11.sp, fontWeight: FontWeight.bold);
  //for textfield hintText
  static TextStyle hintText = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
    color: Colors.grey,
  );
  //for don't have account text
  static TextStyle authBottomText = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w700,
  );
  //for sign up text button
  static TextStyle signUpTextButton = TextStyle(
    fontSize: 11.sp,
    color: AppColor.theme,
    fontWeight: FontWeight.w700,
  );
  // for appBar title
  static TextStyle appbarTitle = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.bold,
  );
  //for location text
  static TextStyle locationText = TextStyle(
    color: AppColor.appbarText,
    fontSize: 9.sp,
    fontWeight: FontWeight.w600,
  );
  //for category name
  static TextStyle catgoryTitle(bool isSelected) => TextStyle(
      fontSize: 10.sp,
      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
      color: isSelected ? Colors.white : Colors.grey);
  //for hospital tile title(name)
  static TextStyle hospitalTileTitle = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
  );
  //for hospital tile subTitle(address)
  static TextStyle hospitalTileSubTitle = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w700,
    color: Colors.grey,
  );
  //for bottomNavigationBar label
  static TextStyle bottomNavigationBarLabel = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 10.sp,
  );
  //for hospital detail(profile)
  static TextStyle hospitalDetail = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black.withOpacity(0.6),
  );
  static TextStyle blogTitle = TextStyle(
      fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white);

  static TextStyle blogDetailCapital = TextStyle(
    fontSize: 25.sp,
    color: Colors.black,
    fontFamily: 'Merriweather',
    fontWeight: FontWeight.w700,
  );
  //connection error screen
  static TextStyle connectionPageLabel = TextStyle(
    fontSize: 15.sp,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static TextStyle connectionPageSubLabel = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: Colors.grey,
  );
}
