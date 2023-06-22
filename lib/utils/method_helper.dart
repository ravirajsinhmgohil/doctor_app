import 'dart:convert';

import 'package:doctor_app/screens/base/bloc/base_bloc.dart';
import 'package:doctor_app/screens/base/data/base_datasource.dart';
import 'package:doctor_app/screens/base/data/base_repository.dart';
import 'package:doctor_app/screens/base/models/update_number_request.dart';
import 'package:doctor_app/screens/hospital_view/bloc/hospital_detail_bloc.dart';
import 'package:doctor_app/screens/hospital_view/model/lead_request.dart';
import 'package:doctor_app/screens/login/model/login_response.dart';
import 'package:doctor_app/utils/color_helper.dart';
import 'package:doctor_app/utils/shared_prefs_helper.dart';
import 'package:doctor_app/utils/strings_helper.dart';
import 'package:doctor_app/utils/validator_helper.dart';
import 'package:doctor_app/widgets/custom_eleveted_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

mixin Methods {
  //for height
  SizedBox height(double height) {
    return SizedBox(
      height: height,
    );
  }

  //for width
  SizedBox width(double width) {
    return SizedBox(
      width: width,
    );
  }

  //for city container decoration
  BoxDecoration cityContainerDecoration() {
    return BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(2.5.h),
    );
  }
 
  //for email field border
  OutlineInputBorder emailFieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.h),
      borderSide: BorderSide(color: Colors.white, width: 0.2.h),
    );
  }
  
  //for search field border
  OutlineInputBorder SearchFieldBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(2.h),
    );
  }
  
  //for signout
  Future<void> signOutGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  Future<void> urlLaunchMethod(
      {required String scheme, required String path}) async {
    try {
      Uri launchUri = Uri(
        scheme: scheme,
        path: path,
      );
      await canLaunchUrl(
        launchUri,
      ).then((value) async {
        if (value == true) {
          await launchUrl(
            launchUri,
            webViewConfiguration: const WebViewConfiguration(),
            mode: LaunchMode.externalApplication,
          );
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> httpsLauch({required String link}) async {
    try {
      Uri launchUri = Uri.parse(link);

      await canLaunchUrl(
        launchUri,
      ).then((value) async {
        if (value == true) {
          await launchUrl(
            launchUri,
            webViewConfiguration: const WebViewConfiguration(),
            mode: LaunchMode.externalApplication,
          );
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<LoginResponse> getLoginData() async {
    String loginData = await SharedPrefs.getLoginData();
    Map<String, dynamic> decodeData =
        jsonDecode(loginData) as Map<String, dynamic>;
    return LoginResponse.fromJson(decodeData);
  }

  Future<LoginResponse> updatNumber({
    required BuildContext context,
    required String hintText,
    required GlobalKey<FormState> key,
    required String userId,
  }) async {
    final TextEditingController numberController =
        TextEditingController(text: hintText);
    var data = await showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) =>
            BaseBloc(repository: BaseRepository(datasource: BaseDatasource())),
        child: Dialog(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.close),
                      )
                    ],
                  ),
                  Text(
                    'Update mobile number',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  TextFormField(
                    maxLength: 10,
                    controller: numberController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      return ValidatorHelper.phoneNumber(
                          value: value!.trim(), context: context);
                    },
                    decoration: const InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocConsumer<BaseBloc, BaseState>(
                        listener: (context, state) {
                          if (state is UpdateMobileNumberSuccessState) {
                            Navigator.of(context)
                                .pop(state.updateNumberResponse);
                            numberController.clear();
                          }
                        },
                        builder: (context, state) {
                          if (state is UpdateMobileNumberBusyState) {
                            return CircularProgressIndicator();
                          } else {
                            return CustomElevetevatedButton(
                              backgroundColor: AppColor.theme,
                              title: Strings.update,
                              onPressed: () {
                                print('update');
                                bool isValid =
                                    key.currentState?.validate() ?? false;
                                print(isValid);
                                if (isValid) {
                                  UpdateNumberRequest updateNumberRequest =
                                      UpdateNumberRequest(
                                          contactNumber: numberController.text,
                                          userId: userId);
                                  context.read<BaseBloc>().add(
                                        UpdateMobileNumberEvent(
                                          updateNumberRequest:
                                              updateNumberRequest,
                                        ),
                                      );
                                }
                              },
                            );
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
    if (data is LoginResponse) {
      return data;
    }

    return data;
  }

  void addLead({
    required BuildContext context,
    required String type,
    required String hospitalId,
  }) {
    getLoginData().then(
      (value) {
        print(value.data?.id);
        LeadRequest leadRequest = LeadRequest(
            type: type,
            hospitalId: hospitalId,
            userId: value.data?.id.toString() ?? '');
        context.read<HospitalDetailBloc>().add(
              AddLeadEvent(leadRequest: leadRequest),
            );
      },
    );
  }
}
