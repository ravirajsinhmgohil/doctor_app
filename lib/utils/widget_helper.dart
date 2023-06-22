import 'package:flutter/material.dart';

class WidgetHelper {
 static customSnackBar(
      {required BuildContext context,
      required String title,
      required Color backgroundColor}) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 900),
        behavior: SnackBarBehavior.floating,
        content: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        backgroundColor: backgroundColor,
      ));
  }
}
