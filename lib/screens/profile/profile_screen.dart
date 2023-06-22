import 'package:doctor_app/screens/hospital_view/profile_tab_view.dart';
import 'package:doctor_app/screens/login/login_screen.dart';
import 'package:doctor_app/screens/login/model/login_response.dart';
import 'package:doctor_app/screens/profile/bloc/profile_bloc.dart';
import 'package:doctor_app/utils/color_helper.dart';
import 'package:doctor_app/utils/image_helper.dart';
import 'package:doctor_app/utils/method_helper.dart';
import 'package:doctor_app/utils/navigate_helper.dart';
import 'package:doctor_app/utils/shared_prefs_helper.dart';
import 'package:doctor_app/utils/strings_helper.dart';
import 'package:doctor_app/utils/text_style_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: ProfileScreenUi(),
    );
  }
}

class ProfileScreenUi extends StatefulWidget {
  const ProfileScreenUi({super.key});

  @override
  State<ProfileScreenUi> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreenUi>
    with Methods, NavigateHelper {
  final GlobalKey<FormState> updateNumberKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  LoginResponse? loginData;
  final TextEditingController phoneNumberController = TextEditingController();
  @override
  void initState() {
    getLoginData().then((value) => loginData = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is GetUpdatedUserDataState) {
          loginData = state.updatedLoginData;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.appBackground,
          appBar: AppBar(
            elevation: 0,
            title: Text(
              Strings.profile,
              style: TextStyleHelper.appbarTitle,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 25.h,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 5.5.h,
                          backgroundImage: const AssetImage(
                            Images.profileImage,
                          ),
                        ),
                        height(2.h),
                      ],
                    ),
                  ),
                ),
                //Build for name
                ProfileTile(
                  onTap: () {},
                  icon: Icons.person,
                  title: Strings.name,
                  subTitle: loginData?.data?.name ?? '',
                ),
                //Build for email
                ProfileTile(
                  icon: Icons.email,
                  title: Strings.emailAddress,
                  subTitle: loginData?.data?.email ?? '',
                ),
                //Build for mobile number
                ProfileTile(
                  icon: Icons.phone,
                  title: Strings.mobileNumber,
                  subTitle: loginData?.data?.contactNumber ?? '',
                  onTap: () async {
                    String userId = loginData?.data?.id.toString() ?? '';
                    if (userId.isNotEmpty) {
                      //for update mobile number
                      await updatNumber(
                              context: context,
                              key: updateNumberKey,
                              hintText: loginData?.data?.contactNumber ?? '',
                              userId: userId)
                          .then(
                        (value) {
                          setState(
                            () {
                              context.read<ProfileBloc>().add(
                                  GetUpdatedUserDataEvent(
                                      updatedLoginData: value));
                            },
                          );
                        },
                      );
                    }
                  },
                ),
                //build for logut
                ProfileTile(
                  icon: Icons.logout,
                  title: Strings.logOut,
                  subTitle: Strings.logOutYourAccount,
                  onTap: () async {
                    //build for log out alert dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Strings.logOut,
                              style: TextStyle(
                                  color: AppColor.theme,
                                  fontWeight: FontWeight.bold),
                            ),
                            Divider(
                              thickness: 0.2.h,
                            )
                          ],
                        ),
                        content: Text(
                          Strings.logoutAlertSubTitle,
                          style: TextStyle(
                              color: AppColor.theme,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                Strings.no,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.themeGreen,
                                ),
                              )),
                          TextButton(
                            onPressed: () async {
                              await signOutGoogle()
                                  .then(
                                    (value) => SharedPrefs.clearToken(),
                                  )
                                  .then(
                                    (value) => pushRemove(
                                      context,
                                      const LoginScreen(),
                                    ),
                                  );
                            },
                            child: Text(
                              Strings.yes,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.themeGreen),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subTitle;
  final void Function()? onTap;
  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    this.subTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CustomCircleImage(
        borderWidth: 0.0.h,
        backgroundColor: AppColor.appBackground,
        radius: 5.h,
        widget: Icon(
          icon,
          color: AppColor.themeGreen,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: subTitle != null
          ? Text(
              subTitle!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10.sp,
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
