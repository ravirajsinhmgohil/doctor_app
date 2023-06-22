import 'package:doctor_app/utils/strings_helper.dart';
import 'package:flutter/material.dart';

class ListHelper {
  //for tab list in hospital view
  static List<Tab> tabList = [
    const Tab(
      text: Strings.profile,
    ),
    const Tab(
      text: Strings.gallary,
    ),
    const Tab(
      text: Strings.doctors,
    ),
    const Tab(
      text: Strings.facilities,
    ),
  ];
}
