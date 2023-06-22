import 'package:flutter/material.dart';

mixin NavigateHelper {
  //for navigate push
  Future<void> push(BuildContext context, Widget widget) async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => widget,
    ));
  }

  Future<void> pushRemove(BuildContext context, Widget widget) async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => widget,
        ),
        (route) => false);
  }
}
