import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    super.key,
    required this.image,
    this.containerHeight,
    this.containerWidth,
    required this.fit,
  });

  final String image;
  final double? containerHeight;
  final double? containerWidth;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: fit),
        ),
        height: containerHeight ?? double.infinity,
        width: containerWidth ?? double.infinity,
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey.shade300,
        child: Container(
          height: containerHeight,
          width: containerWidth,
          color: Colors.grey.shade100,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey.shade300,
        height: double.infinity,
        width: double.infinity,
        child: Icon(
          Icons.error_outline,
          size: 25.sp,
        ),
      ),
    );
  }
}
