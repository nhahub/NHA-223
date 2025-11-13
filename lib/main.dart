import 'package:final_depi_project/features/auth/sign_in_screen.dart';
import 'package:final_depi_project/features/home_screen/home_screen.dart';
import 'package:final_depi_project/features/home_screen/tabs/orders_tab/screens/review_screen.dart';
import 'package:final_depi_project/features/home_screen/tabs/orders_tab/screens/track_order2_screen.dart';
import 'package:final_depi_project/features/home_screen/tabs/orders_tab/screens/track_order_screen.dart';
import 'package:final_depi_project/features/product_detail/product_details.dart';
import 'package:final_depi_project/firebase_options.dart';
import 'package:final_depi_project/helpers/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
 import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/auth/sign_up_screen.dart';
import 'features/home_screen/tabs/home_tab/home_tab.dart';
import 'features/home_screen/tabs/profile_tab/edit_profile_screen.dart';
import 'features/onboarding/onbourdingmain.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
          Routes.onboardingMain: (context) => OnboardingMain(),
          Routes.productDetails: (context) => ProductDetails(),
          Routes.homeScreen: (context) => HomeScreen(),
          Routes.editProfileScreen: (context) => EditProfileScreen(),
        },
        initialRoute: Routes.editProfileScreen,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
      ),
    ),
  );
}
