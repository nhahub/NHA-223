import 'package:final_depi_project/helpers/routes.dart';
import 'package:final_depi_project/screens/sign_in_screen.dart';
import 'package:final_depi_project/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        Routes.signupScreen: (context) => SignUpScreen(),
        Routes.signinScreen: (context) => const SignInScreen(),
      },

      initialRoute: Routes.signinScreen,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
    ),
  );
}
