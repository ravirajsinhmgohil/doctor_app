import 'package:doctor_app/screens/base/base_screen.dart';
import 'package:doctor_app/screens/login/login_screen.dart';
import 'package:doctor_app/utils/color_helper.dart';
import 'package:doctor_app/utils/image_helper.dart';
import 'package:doctor_app/utils/shared_prefs_helper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigateToHome() async {
    String? token = await SharedPrefs.getToken();
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) =>
                token.isEmpty ? const LoginScreen() : const BaseScreen(),
          ),
          (route) => false);
    });
  }

  @override
  void initState() {
    navigateToHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.theme,
      body: Center(child: Image.asset(Images.appLogo)),
    );
  }
}
