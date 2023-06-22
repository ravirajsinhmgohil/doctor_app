import 'package:flutter/material.dart';

import '../utils/text_style_helper.dart';

class AuthScreenBottom extends StatelessWidget {
  final String label;
  final String textButtonTitle;
  final void Function()? onPressed;
  const AuthScreenBottom({
    super.key,
    required this.label,
    required this.textButtonTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyleHelper.authBottomText,
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            textButtonTitle,
            style: TextStyleHelper.signUpTextButton,
          ),
        )
      ],
    );
  }
}
