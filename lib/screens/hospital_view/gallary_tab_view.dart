import 'package:doctor_app/screens/hospital_view/image_view/image_view_screen.dart';
import 'package:doctor_app/screens/hospital_view/model/gallary_response.dart';
import 'package:doctor_app/utils/api_helper.dart';
import 'package:doctor_app/utils/navigate_helper.dart';
import 'package:doctor_app/widgets/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class GallaryTabView extends StatefulWidget {
  final List<ImageResponse> imageList;

  const GallaryTabView({super.key, required this.imageList});

  @override
  State<GallaryTabView> createState() => _GallaryTabViewUiState();
}

class _GallaryTabViewUiState extends State<GallaryTabView> with NavigateHelper {
  @override
  Widget build(BuildContext context) {
    return widget.imageList.isEmpty
        ? const Center(
            child: Text('No image available'),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 1.h),
            child: GridView.builder(
              itemCount: widget.imageList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4 / 3.2,
                mainAxisSpacing: 1.h,
                crossAxisSpacing: 1.h,
              ),
              itemBuilder: (context, index) {
                String gallaryImage =
                    '${Api.baseUrl}gallery/${widget.imageList[index].photo}';
                return InkWell(
                  onTap: () {
                    push(
                      context,
                      ImageViewScreen(
                        image: gallaryImage,
                        index: index,
                        imageList: widget.imageList,
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1.h),
                    child: CustomCachedImage(
                        fit: BoxFit.fill,
                        image: gallaryImage,
                        containerHeight: 30.h),
                  ),
                );
              },
            ),
          );
  }
}
