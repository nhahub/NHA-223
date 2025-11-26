import 'dart:math';

import 'package:final_depi_project/core/shared_prefrences.dart';
import 'package:final_depi_project/features/auth/auth_service.dart';
import 'package:final_depi_project/features/auth/cubit/auth_cubit.dart';
import 'package:final_depi_project/features/auth/cubit/auth_states.dart';
import 'package:final_depi_project/features/auth/google_service.dart';
import 'package:final_depi_project/helpers/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController(
    text: "marwanreda@gmail.com"
  );
  TextEditingController passwordController = TextEditingController(
    text: "Mawran@123"
  );
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;
  DateTime? _lastSnackBarTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthCubit,AuthState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            // print("this is my token: ${AppSharedPreferences.getString(SharedPreferencesKeys.token)}");
            Navigator.pushReplacementNamed(context, Routes.homeScreen);
          }else if(state is LoginErrorState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message),backgroundColor: Colors.red,)
            );
          }
        },
        builder:(context, state) {
          bool isLoading=state is LoginLoadingState;
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    //!---------------------------------------------------"Sign in"
                    SizedBox(height: 120.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "Sign In",
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
                            // height: 44.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: Color(0xFFF4F4F4),
                            ),
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                label: Text("Mail"),
                                hintText: "enter your email",
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty)
                                  return 'Please enter your email';
                                final emailRegex = RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                );
                                if (!emailRegex.hasMatch(value.trim()))
                                  return 'Enter a valid email';
                                return null;
                              },
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
                            // height: 44.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: Color(0xFFF4F4F4),
                            ),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: _obscure,
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
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return 'Please enter your password';
                                if (value.length < 8)
                                  return 'Password must be at least 8 characters';
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    //!-------------------------------------------"forget password"
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forget Password ?  ",
                          style: TextStyle(
                            color: Color(0xFF5B36FF),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    //!---------------------------------------------"signin button"
                    SizedBox(height: 48.h),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().login(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }
                      },
                      child: Container(
                        width: 343.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: Colors.black,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child:
                              isLoading? CircularProgressIndicator(
                                color: Colors.cyan,
                              ):Text(
                                "Sign In",
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
                    ),
                    //!--------------------------------------------"or login with"
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: 343.w,
                      height: 102.h,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 343.w,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    var user =
                                    await AuthService2.signInWithGoogle();
                                    if (user != null) {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        Routes.homeScreen,
                                      );
                                    }
                                  },
                                  child: Image.asset('assets/images/Google.png'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //!----------------------------"u do not have account sign up "
                    SizedBox(height: 90.h),
                    SizedBox(
                      width: double.infinity.h,
                      // height: 25.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You Don’t Have an account ?",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                Routes.signupScreen,
                              );
                            },
                            child: Text(
                              "sign up",
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
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
