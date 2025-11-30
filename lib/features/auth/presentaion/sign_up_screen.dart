import 'package:final_depi_project/features/auth/cubit/auth_cubit.dart';
import 'package:final_depi_project/features/auth/cubit/auth_states.dart';
import 'package:final_depi_project/helpers/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;
  bool _obscure2 = true;
  DateTime? _lastSnackBarTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is SignupErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is SignupSuccessState) {
              Navigator.pushReplacementNamed(context, Routes.homeScreen);
            }
          },
          builder: (context, state) {
            bool isLoading = state is SignupLoadingState;
            return Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    //!---------------------------------------------------"Sign Up"
                    SizedBox(height: 80.h),
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
                    SizedBox(height: 20.h),
                    //!----------------------------------------------------"E-Mail"
                    SizedBox(
                      width: 343.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 4),
                          TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              label: Text("Name"),
                              hintText: "enter your name",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty)
                                return 'Please enter your name';
                              if (value.length < 5) return 'Enter a valid name';
                              return null;
                            },
                          ),

                          SizedBox(height: 20.h),
                          Text(
                            "E-Mail",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 4),
                          TextFormField(
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
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _obscure = !_obscure;
                                    });
                                  },
                                  child: Image.asset(
                                    'assets/images/Lock.png',
                                    width: 24.w,
                                    height: 24.h,
                                  ),
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
                            // height: 44.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: Color(0xFFF4F4F4),
                            ),
                            child: TextFormField(
                              controller: rePasswordController,
                              obscureText: _obscure2,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                label: Text("Enter Password"),
                                hintText: "enter your password",
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _obscure2 = !_obscure2;
                                    });
                                  },
                                  child: Image.asset(
                                    'assets/images/Lock.png',
                                    width: 24.w,
                                    height: 24.h,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    //!---------------------------------------------"signup button"
                    SizedBox(height: 48.h),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().signup(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                rePassword: rePasswordController.text,
                              );
                            }
                          } catch (e) {
                            // Prevent showing the same SnackBar repeatedly within 3 seconds
                            final now = DateTime.now();
                            if (_lastSnackBarTime == null ||
                                now.difference(_lastSnackBarTime!) >
                                    const Duration(seconds: 3)) {
                              _lastSnackBarTime = now;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Email or password are incorrect',
                                  ),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                        }
                      },
                      child: Container(
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
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().signup(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    rePassword: rePasswordController.text,
                                  );
                                }
                              },
                              child: isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.cyan,
                                    )
                                  : Text(
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
                    ),
                    //!---------------------------------------------"or login with"
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: 343.w,
                      height: 90.h,
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
                                  onTap: () async {
                                    // var user =
                                    //     await AuthService2.signInWithGoogle();
                                    // if (user != null) {
                                    //   Navigator.pushReplacementNamed(
                                    //     context,
                                    //     Routes.homeScreen,
                                    //   );
                                    // }
                                  },
                                  child: Image.asset(
                                    'assets/images/Google.png',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //!-----------------------------------"u have account sign in "
                    SizedBox(height: 28.h),
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
                            Navigator.popAndPushNamed(
                              context,
                              Routes.signinScreen,
                            );
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
            );
          },
        ),
      ),
    );
  }
}
