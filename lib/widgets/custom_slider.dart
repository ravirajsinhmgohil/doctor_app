import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor_app/screens/home/model/sllider_response.dart';
import 'package:doctor_app/utils/api_helper.dart';
import 'package:doctor_app/utils/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    super.key,
    required this.imgList,
  });

  final List<SliderResponse> imgList;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        ...imgList.map((e) {
          return CachedNetworkImage(
            imageUrl: '${Api.baseUrl}slider/${e.image}',
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                color: AppColor.appBackground,
                image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
              ),
              height: double.infinity,
              width: double.infinity,
            ),
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.grey.shade300,
              child: Container(
                height: 30.h,
                color: Colors.grey.shade100,
              ),
            ),
            errorWidget: (context, url, error) => const SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Icon(Icons.error_outline),
            ),
          );
        })
      ],
      options: CarouselOptions(
        height: 30.h,
        autoPlay: true,
        viewportFraction: 1,
      ),
    );
  }
}
