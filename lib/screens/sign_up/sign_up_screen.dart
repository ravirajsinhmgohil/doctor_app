import 'package:doctor_app/screens/base/base_screen.dart';
import 'package:doctor_app/utils/color_helper.dart';
import 'package:doctor_app/utils/method_helper.dart';
import 'package:doctor_app/utils/navigate_helper.dart';
import 'package:doctor_app/utils/strings_helper.dart';
import 'package:doctor_app/utils/text_style_helper.dart';
import 'package:doctor_app/widgets/auth_screen_bottom.dart';
import 'package:doctor_app/widgets/custom_eleveted_button.dart';
import 'package:doctor_app/widgets/custom_logo.dart';
import 'package:doctor_app/widgets/custom_text_field.dart';
import 'package:doctor_app/widgets/text_field_label.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SignUpscreen extends StatefulWidget {
  const SignUpscreen({super.key});

  @override
  State<SignUpscreen> createState() => _SignUpscreenState();
}

class _SignUpscreenState extends State<SignUpscreen>
    with Methods, NavigateHelper {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _contactNo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.grey.shade300,
          ),
          Positioned(
            top: 35.h,
            left: 0,
            height: 100.h,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  3.h,
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 3.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.signUpWithLine,
                      style: TextStyleHelper.authScreenTitle,
                    ),
                    height(3.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.h),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Build for email
                            const TextFieldLabel(label: Strings.name),
                            CustomTextField(
                              hintText: Strings.yourName,
                              controller: _name,
                            ),
                            height(1.h),
                            //Build for password
                            const TextFieldLabel(label: Strings.email),
                            CustomTextField(
                              hintText: Strings.email,
                              controller: _email,
                            ),
                            height(1.h),
                            //Build for password
                            const TextFieldLabel(label: Strings.contactNo),
                            CustomTextField(
                              hintText: Strings.yourContactNo,
                              controller: _contactNo,
                            ),
                            height(1.h),
                            //Build for password
                            const TextFieldLabel(label: Strings.password),
                            CustomTextField(
                              hintText: Strings.password,
                              controller: _password,
                            ),
                            height(3.h),
                            //Build for login button
                            CustomElevetevatedButton(
                              backgroundColor: AppColor.theme,
                              onPressed: () {
                                push(context, const BaseScreen());
                              },
                              title: Strings.signUp,
                            ),
                            height(2.h),
                            //Build for sign up navigation
                            AuthScreenBottom(
                              label: Strings.alreadyHave,
                              textButtonTitle: Strings.login,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const CustomLogo()
        ],
      ),
    );
  }
}
