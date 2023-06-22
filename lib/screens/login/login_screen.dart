import 'dart:convert';

import 'package:doctor_app/screens/base/base_screen.dart';
import 'package:doctor_app/screens/connection_error/bloc/connection_error_bloc.dart';
import 'package:doctor_app/screens/connection_error/connection_error.dart';
import 'package:doctor_app/screens/hospital_view/profile_tab_view.dart';
import 'package:doctor_app/screens/login/bloc/login_bloc.dart';
import 'package:doctor_app/screens/login/data/login_datasource.dart';
import 'package:doctor_app/screens/login/data/login_repository.dart';
import 'package:doctor_app/screens/login/model/login_response.dart';
import 'package:doctor_app/utils/color_helper.dart';
import 'package:doctor_app/utils/image_helper.dart';
import 'package:doctor_app/utils/method_helper.dart';
import 'package:doctor_app/utils/navigate_helper.dart';
import 'package:doctor_app/utils/shared_prefs_helper.dart';
import 'package:doctor_app/utils/strings_helper.dart';
import 'package:doctor_app/utils/text_style_helper.dart';
import 'package:doctor_app/utils/validator_helper.dart';
import 'package:doctor_app/widgets/custom_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConnectionErrorBloc()..add(GetConnectionStatus()),
      child: BlocProvider(
        create: (context) => LoginBloc(
          repository: LoginRepository(
            datasource: LoginDatasource(),
          ),
        ),
        child: const LoginScreenUi(),
      ),
    );
  }
}

class LoginScreenUi extends StatefulWidget with NavigateHelper {
  const LoginScreenUi({super.key});

  @override
  State<LoginScreenUi> createState() => _LoginScreenUiState();
}

class _LoginScreenUiState extends State<LoginScreenUi>
    with Methods, NavigateHelper {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectionErrorBloc, ConnectionErrorState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is CheckConnectionFailureState) {
          return const ConnectionErrorScreen();
        } else {
          return BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginWithGoogleSuccessState) {
                pushRemove(
                  context,
                  BaseScreen(),
                );
              }
            },
            builder: (context, state) {
              return Scaffold(
                backgroundColor: AppColor.theme,
                body: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.h,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Form(
                            key: loginKey,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomLogo(),
                                  height(3.h),
                                  if (isVisible == true) ...[
                                    TextFormField(
                                      cursorColor: Colors.white,
                                      controller: _emailController,
                                      style: TextStyle(color: Colors.white),
                                      validator: (value) =>
                                          ValidatorHelper.email(
                                              value: value?.trim(),
                                              context: context),
                                      decoration: InputDecoration(
                                        focusColor: Colors.white,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 2.h,
                                          vertical: 1.8.h,
                                        ),
                                        focusedBorder: emailFieldBorder(),
                                        enabledBorder: emailFieldBorder(),
                                        errorBorder: emailFieldBorder(),
                                        focusedErrorBorder: emailFieldBorder(),
                                        border: emailFieldBorder(),
                                        hintText: Strings.enterEmail,
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        suffixIconColor: Colors.white,
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.all(0.5.h),
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(5.h),
                                            onTap: () {
                                              bool isValid = loginKey
                                                      .currentState
                                                      ?.validate() ??
                                                  false;

                                              if (isValid) {
                                                if (_emailController.text ==
                                                    Strings.demoEmail) {
                                                  LoginResponse loginResponse =
                                                      LoginResponse(
                                                    data: Data(
                                                        contactNumber:
                                                            Strings.demoNumber,
                                                        email:
                                                            Strings.demoEmail,
                                                        id: Strings.demoUserId,
                                                        name: Strings
                                                            .demoUserName),
                                                  );
                                                  String loginData =
                                                      jsonEncode(loginResponse);
                                                  SharedPrefs.setLoginData(
                                                      loginData: loginData);
                                                  pushRemove(
                                                      context, BaseScreen());
                                                }
                                              }
                                            },
                                            child: CustomCircleImage(
                                              radius: 5.5.h,
                                              backgroundColor:
                                                  AppColor.themeGreen,
                                              borderColor: Colors.white,
                                              borderWidth: 0.2.h,
                                              widget: Icon(
                                                Icons.arrow_forward_rounded,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ] else ...[
                                    SizedBox(
                                      height: 6.h,
                                    )
                                  ]
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding: EdgeInsets.only(
                    left: 2.h,
                    right: 2.h,
                    bottom: 4.h,
                  ),
                  child: state is LoginWithGoogleBusyState
                      ? CustomLoader(color: Colors.white)
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.white, width: 0.2.h),
                                  borderRadius: BorderRadius.circular(5.h),
                                ),
                                backgroundColor: AppColor.theme,
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.5.h, horizontal: 1.h),
                              ),
                              onPressed: () {
                                context.read<LoginBloc>().add(
                                      LoginWithGoogleEvent(),
                                    );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomCircleImage(
                                    backgroundColor: AppColor.theme,
                                    borderColor: AppColor.theme,
                                    borderWidth: 0,
                                    radius: 5.h,
                                    imagePath: Images.googleLogo,
                                  ),
                                  width(1.h),
                                  Text(
                                    Strings.continueWithGoogle,
                                    textAlign: TextAlign.center,
                                    style: TextStyleHelper.googleLoginText,
                                  ),
                                  width(2.h)
                                ],
                              ),
                            ),
                            height(2.h),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              child: Container(
                                height: 6.h,
                                alignment: Alignment.center,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, width: 0.2.h),
                                  borderRadius: BorderRadius.circular(6.h),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    width(2.h),
                                    Text(
                                      Strings.continueWithOther,
                                      style: TextStyleHelper.googleLoginText,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

class CustomLoader extends StatelessWidget {
  final Color color;
  const CustomLoader({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      );
    });
  }
}
