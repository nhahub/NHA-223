import 'package:final_depi_project/core/shared_prefrences.dart';
import 'package:final_depi_project/features/home_screen/tabs/profile_tab/widgets/custom_text_field.dart';
import 'package:final_depi_project/utils/app_assets.dart';
import 'package:final_depi_project/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final TextEditingController nameController = TextEditingController(
    text: AppSharedPreferences.getString(SharedPreferencesKeys.name),
  );
  final TextEditingController emailController = TextEditingController(
    text: AppSharedPreferences.getString(SharedPreferencesKeys.email),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Edit Profile", style: AppStyles.body3Bold),
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
                          AppSharedPreferences.setString(SharedPreferencesKeys.name, nameController.text);
                          AppSharedPreferences.setString(SharedPreferencesKeys.email, emailController.text);
                          Navigator.pop(context,true);
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

