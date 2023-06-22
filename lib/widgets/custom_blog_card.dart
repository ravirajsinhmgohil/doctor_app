import 'package:doctor_app/screens/blog_view/blog_view_screen.dart';
import 'package:doctor_app/utils/method_helper.dart';
import 'package:doctor_app/utils/navigate_helper.dart';
import 'package:doctor_app/widgets/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomBlogCard extends StatelessWidget with Methods, NavigateHelper {
  final FocusNode focusNode;
  final String name;
  final String title;
  final String image;
  final String detail;
  final String blogId;
  const CustomBlogCard({
    super.key,
    required this.title,
    required this.image,
    required this.detail,
    required this.blogId,
    required this.focusNode,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(1.h);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.7.h, vertical: 0.5.h),
      child: InkWell(
        onTap: () {
          focusNode.unfocus();
          push(
            context,
            BlogViewScreen(blogId: blogId),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromARGB(72, 2, 42, 83)),
            borderRadius: BorderRadius.circular(1.5.h),
          ),
          child: Padding(
            padding: EdgeInsets.all(0.5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 22.h,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.only(topLeft: radius, topRight: radius),
                    child: CustomCachedImage(
                      image: image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                height(0.5.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Build for for blog title
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      height(0.5.h),
                      //Build for blog detail
                      Text(
                        detail,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      //Build for blog name
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
