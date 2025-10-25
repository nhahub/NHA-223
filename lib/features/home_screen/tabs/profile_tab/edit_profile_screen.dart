import 'package:final_depi_project/features/home_screen/tabs/profile_tab/widgets/custom_text_field.dart';
import 'package:final_depi_project/utils/app_assets.dart';
import 'package:final_depi_project/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final TextEditingController nameController = TextEditingController(
    text: 'Mona Ahmed',
  );
  final TextEditingController emailController = TextEditingController(
    text: "monaahmed22@gmail.com",
  );
  final TextEditingController passwordController = TextEditingController(
    text: "...............",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Personal Info", style: AppStyles.body3Bold),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 44,
                              backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?q=80&w=400',
                              ),
                              backgroundColor: Color(0xFFE0E0E0),
                            ),
                            Container(
                              height: 28.h,
                              width: 28.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Icon(Icons.edit, size: 16.sp),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 28.h),
                      Text('Name', style: AppStyles.head3),
                      SizedBox(height: 8.h),
                      CustomTextFieldEditProfile(
                        nameController: nameController,
                      ),
                      SizedBox(height: 20.h),
                      Text('E-Mail', style: AppStyles.head3),
                      SizedBox(height: 8.h),
                      CustomTextFieldEditProfile(
                        nameController: emailController,
                      ),
                      SizedBox(height: 20.h),
                      Text('Password', style: AppStyles.head3),
                      SizedBox(height: 8.h),
                      CustomTextFieldEditProfile(
                        nameController: passwordController,
                        suffixIcon: Image.asset(
                          AppAssets.lockIcon,
                          width: 24.w,
                          height: 24.h,
                        ),
                      ),
                      SizedBox(height: 120.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius:BorderRadiusGeometry.circular(16.r)
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          // TODO: handle "Edit personal Info"
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                            'Edit personal Info',
                            style: AppStyles.body2Black.copyWith(
                              color: Colors.white,
                            ),
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
      ),
    );
  }
}

