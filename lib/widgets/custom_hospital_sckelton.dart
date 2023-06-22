import 'package:doctor_app/utils/color_helper.dart';
import 'package:doctor_app/utils/method_helper.dart';
import 'package:doctor_app/utils/navigate_helper.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class CustomHospitalSkelton extends StatelessWidget
    with Methods, NavigateHelper {
  const CustomHospitalSkelton({super.key});

  @override
  Widget build(BuildContext context) {
    final tileRadius = BorderRadius.circular(2.h);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 1.h),
      child: InkWell(
        borderRadius: tileRadius,
        onTap: () {},
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade400,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: tileRadius,
              border: Border.all(
                color: AppColor.border,
              ),
            ),
            height: 13.h,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(0.8.h),
              child: Row(
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: 30.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1.h),
                      child: Container( 
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  width(1.h),
                  SizedBox(
                    width: 58.w,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.5.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: placeHolderRadious(),
                            width: 58.w,
                            height: 2.h,
                          ),
                          height(1.8.h),
                          Container(
                            decoration: placeHolderRadious(),
                            width: 58.w,
                            height: 1.4.h,
                          ),
                          height(0.7.h),
                          Container(
                            decoration: placeHolderRadious(),
                            width: 58.w,
                            height: 1.4.h,
                          ),
                          height(0.7.h),
                          Container(
                            decoration: placeHolderRadious(),
                            width: 27.w,
                            height: 1.4.h,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration placeHolderRadious() {
    return BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(0.5.h));
  }
}
