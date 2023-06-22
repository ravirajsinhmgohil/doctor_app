import 'package:doctor_app/screens/hospital_view/model/gallary_response.dart';
import 'package:doctor_app/utils/api_helper.dart';
import 'package:doctor_app/utils/color_helper.dart';
import 'package:doctor_app/widgets/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewScreen extends StatelessWidget {
  final String image;
  final int index;
  final List<ImageResponse> imageList;
  const ImageViewScreen(
      {super.key,
      required this.image,
      required this.imageList,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(86, 2, 42, 83),
        foregroundColor: AppColor.appbarText,
      ),
      body: PhotoViewGallery.builder(
        backgroundDecoration: BoxDecoration(color: AppColor.appBackground),
        itemCount: imageList.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions.customChild(
            child: CustomCachedImage(
                image: '${Api.baseUrl}gallery/${imageList[index].photo}',
                fit: BoxFit.contain),
          );
        },
        pageController: PageController(
          initialPage: index,
        ),
      ),
    );
  }
}
