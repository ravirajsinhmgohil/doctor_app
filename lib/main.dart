import 'package:doctor_app/screens/splash/splash_screen.dart';
import 'package:doctor_app/utils/color_helper.dart';
import 'package:doctor_app/utils/strings_helper.dart';
import 'package:doctor_app/widgets/custom_dismiss_keyboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'screens/connection_error/bloc/connection_error_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return DismissKeyboard(
          child: BlocProvider(
            create: (context) => ConnectionErrorBloc()
              ..add(
                GetConnectionStatus(),
              ),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Strings.doctorApp,
              theme: ThemeData(
                fontFamily: 'OpenSans',
                primarySwatch: Colors.blue,
                appBarTheme: const AppBarTheme(
                  backgroundColor: AppColor.theme,
                  titleTextStyle: TextStyle(color: AppColor.themeGreen),
                ),
              ),
              home: const SplashScreen(),
            ),
          ),
        );
      },
    );
  }
}
