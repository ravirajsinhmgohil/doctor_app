import 'package:doctor_app/utils/image_helper.dart';
import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(Images.appLogo);
  }
}
