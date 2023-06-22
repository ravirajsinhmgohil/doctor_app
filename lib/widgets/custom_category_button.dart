import 'package:doctor_app/utils/color_helper.dart';
import 'package:doctor_app/utils/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomCategoryButton extends StatelessWidget {
  final bool isAll;
  final bool isSelected;
  final void Function()? onTap;
  const CustomCategoryButton({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
    required this.isAll,
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(1.h);
    return InkWell(
      borderRadius: radius,
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColor.theme : Colors.white,
          border: Border.all(
            color: isSelected ? AppColor.theme : AppColor.border,
          ),
          borderRadius: BorderRadius.circular(1.h),
        ),
        child: Padding(
          padding: isAll
              ? EdgeInsets.symmetric(horizontal: 2.h)
              : EdgeInsets.symmetric(horizontal: 1.h),
          child: Text(
            category,
            style: TextStyleHelper.catgoryTitle(isSelected),
          ),
        ),
      ),
    );
  }
}
