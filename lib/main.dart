import 'package:final_depi_project/helpers/routes.dart';
import 'package:final_depi_project/screens/review_screen.dart';
import 'package:final_depi_project/screens/sign_in_screen.dart';
import 'package:final_depi_project/screens/sign_up_screen.dart';
import 'package:final_depi_project/screens/track_order2_screen.dart';
import 'package:final_depi_project/screens/track_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        Routes.signupScreen: (context) => SignUpScreen(),
        Routes.signinScreen: (context) => SignInScreen(),
        Routes.reviewScreen: (context) => ReviewScreen(),
        Routes.trackorder: (context) => TrackOrderScreen(),
        Routes.trackorder2: (context) => TrackOrderScreen2(),
      },

      initialRoute: Routes.trackorder,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
    ),
  );
}
