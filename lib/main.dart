import 'package:final_depi_project/helpers/routes.dart';
import 'package:final_depi_project/screens/review_screen.dart';
import 'package:final_depi_project/features/auth/sign_in_screen.dart';
import 'package:final_depi_project/screens/track_order2_screen.dart';
import 'package:final_depi_project/screens/track_order_screen.dart';
import 'package:flutter/material.dart';
 import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/auth/sign_up_screen.dart';
import 'features/home_screen/tabs/home_tab/home_tab.dart';
import 'features/onboarding/onbourdingmain.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: Size(375, 812),
      builder:(context, child) =>  MaterialApp(
        routes: {
          Routes.signupScreen: (context) => SignUpScreen(),
          Routes.signinScreen: (context) => SignInScreen(),
          Routes.reviewScreen: (context) => ReviewScreen(),
          Routes.trackorder: (context) => TrackOrderScreen(),
          Routes.trackorder2: (context) => TrackOrderScreen2(),
          Routes.homeTab: (context) => HomeTab(),
          Routes.OnboardingMain: (context) => OnboardingMain(),

        },
      
        initialRoute: Routes.OnboardingMain,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
      ),
    ),
  );
}
