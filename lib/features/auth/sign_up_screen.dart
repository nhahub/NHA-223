import 'package:final_depi_project/helpers/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              //!---------------------------------------------------"Sign Up"
              SizedBox(height: 120.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 48.h),
              //!----------------------------------------------------"E-Mail"
              SizedBox(
                width: 343.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "E-Mail",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      width: 343.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: Color(0xFFF4F4F4),
                      ),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          label: Text("Mail"),
                          hintText: "enter your email",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //!--------------------------------------------------"password"
              SizedBox(height: 24.h),
              SizedBox(
                width: 343.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      width: 343.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: Color(0xFFF4F4F4),
                      ),
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          label: Text("Enter Password"),
                          hintText: "enter your password",
                          suffixIcon: Image.asset(
                            'assets/images/Lock.png',
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //!------------------------------------------"confirm password"
              SizedBox(height: 24),
              SizedBox(
                width: 343.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Confirm Password",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      width: 343.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: Color(0xFFF4F4F4),
                      ),
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          label: Text("Enter Password"),
                          hintText: "enter your password",
                          suffixIcon: Image.asset(
                            'assets/images/Lock.png',
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //!---------------------------------------------"signup button"
              SizedBox(height: 48.h),
              Container(
                width: 343.w,
                // height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Routes.homeScreen);
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //!---------------------------------------------"or login with"
              SizedBox(height: 24.h),
              SizedBox(
                width: 343.w,
                height: 102.h,
                child: Column(
                  children: [
                    SizedBox(
                      width: 343.w,
                      // height: 22.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "_______________Or Login with_______________",
                            style: TextStyle(
                              color: Color(0xFF8E8E8E),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: 343.w,
                      // height: 56.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset('assets/images/Google.png'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //!-----------------------------------"u have account sign in "
              SizedBox(height: 48.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You Have an account ?",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, Routes.signinScreen);
                    },
                    child: Text(
                      "sign in",
                      style: TextStyle(
                        color: Color(0xFF5B36FF),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF5B36FF),
                        decorationThickness: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
