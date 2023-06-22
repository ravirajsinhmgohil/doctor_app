import 'package:doctor_app/utils/text_style_helper.dart';
import 'package:flutter/material.dart';

class TextFieldLabel extends StatelessWidget {
  final String label;
  const TextFieldLabel({
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyleHelper.authScreenLabel,
    );
  }
}
