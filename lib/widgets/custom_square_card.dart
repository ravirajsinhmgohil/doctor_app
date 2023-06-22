import 'package:doctor_app/utils/method_helper.dart';
import 'package:doctor_app/widgets/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomSquareCard extends StatelessWidget with Methods {
  final String image;
  final String title;
  final String? subTitle;
  final String? text;
  const CustomSquareCard(
      {super.key,
      required this.image,
      required this.title,
      this.subTitle,
      this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0.5.h),
                //Build for doctor image
                child: CustomCachedImage(
                  fit: BoxFit.fill,
                  image: image,
                ),
              ),
            ),
            height(1.h),
            width(3.h),
            SizedBox(
              width: 28.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Build for doctor name
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                  ),
                  height(0.5.h),
                  if (subTitle?.isNotEmpty ?? false)
                    Text(
                      subTitle!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (text?.isNotEmpty ?? false)
                    Text(
                      text!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
