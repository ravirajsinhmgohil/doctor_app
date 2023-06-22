import 'package:doctor_app/utils/strings_helper.dart';
import 'package:flutter/material.dart';

class ValidatorHelper {
  static email({required String? value, required BuildContext context}) {
    return value?.isEmpty ?? false
        ? 'Enter email address.'
        : !value!.contains(Strings.demoEmail
                // RegExp(
                //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
                )
            ? 'Invalid email'
            : null;
  }

  static password({required String? value, required BuildContext context}) {
    return value?.isEmpty ?? false
        ? 'Enter password'
        : value!.length < 6
            ? 'Password must be 6 character.'
            : null;
  }

  static conformPassword(
      {required String? value,
      required firstPassword,
      required BuildContext context}) {
    return value?.isEmpty ?? false
        ? 'Enter conform password'
        : value!.length < 6
            ? 'password must be 6 character'
            : value != firstPassword
                ? 'Password must be same'
                : null;
  }

  static phoneNumber({required String? value, required BuildContext context}) {
    return value?.isEmpty ?? false
        ? 'Enter phone number'
        : (value!.length < 10) || (value.length > 10)
            ? 'Invalid phone number'
            : null;
  }
}
