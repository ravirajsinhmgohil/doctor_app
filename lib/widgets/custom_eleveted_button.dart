import 'package:flutter/material.dart';

class CustomElevetevatedButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  const CustomElevetevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
