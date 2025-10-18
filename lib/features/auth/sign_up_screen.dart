import 'package:flutter/material.dart';

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
          child: Container(
            width: 375,
            height: 812,

            child: Column(
              children: [
                //!---------------------------------------------------"Sign Up"
                SizedBox(height: 120),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 93,
                      height: 34,
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 48),
                //!----------------------------------------------------"E-Mail"
                Container(
                  width: 343,
                  height: 84,
                  child: Column(
                    children: [
                      Container(
                        width: 343,
                        height: 28,
                        child: Text(
                          "E-Mail",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: 343,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xFFF4F4F4),
                        ),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
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
                SizedBox(height: 24),
                Container(
                  width: 343,
                  height: 84,
                  child: Column(
                    children: [
                      Container(
                        width: 343,
                        height: 28,
                        child: Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: 343,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xFFF4F4F4),
                        ),
                        child: TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            label: Text("Enter Password"),
                            hintText: "enter your password",
                            suffixIcon: Image.asset(
                              'assets/Lock.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //!------------------------------------------"confirm password"
                SizedBox(height: 24),
                Container(
                  width: 343,
                  height: 84,
                  child: Column(
                    children: [
                      Container(
                        width: 343,
                        height: 28,
                        child: Text(
                          "Confirm Password",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: 343,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xFFF4F4F4),
                        ),
                        child: TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            label: Text("Enter Password"),
                            hintText: "enter your password",
                            suffixIcon: Image.asset(
                              'assets/Lock.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //!---------------------------------------------"signup button"
                SizedBox(height: 48),
                Container(
                  width: 343,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //!---------------------------------------------"or login with"
                SizedBox(height: 24),
                Container(
                  width: 343,
                  height: 102,
                  child: Column(
                    children: [
                      Container(
                        width: 343,
                        height: 22,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "_______________Or Login with_______________",
                              style: TextStyle(
                                color: Color(0xFF8E8E8E),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        width: 343,
                        height: 56,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Image.asset('assets/Google.png'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //!-----------------------------------"u have account sign in "
                SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You Have an account ?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "sign in",
                        style: TextStyle(
                          color: Color(0xFF5B36FF),
                          fontSize: 16,
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
      ),
    );
  }
}
