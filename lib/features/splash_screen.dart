import 'dart:async';
import 'package:final_depi_project/features/auth/presentaion/sign_in_screen.dart';
import 'package:final_depi_project/features/home_screen/home_screen.dart';
import 'package:final_depi_project/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'category/presentaion/category_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>SignInScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: 228,
          height: 97,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), 
            
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 40,
          ),
          child: SvgPicture.asset(AppAssets.splashImage),
        ),
      ),
    );
  }
}