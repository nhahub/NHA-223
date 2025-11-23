import 'dart:async';
import 'package:flutter/material.dart';
import 'category/category_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>CategoryScreen()),
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
          child: Image.asset(
            'assets/images/1.png',
            width: 250,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}