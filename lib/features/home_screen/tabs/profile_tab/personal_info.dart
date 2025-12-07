import 'package:final_depi_project/core/shared_prefrences.dart';
import 'package:final_depi_project/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String name =
        AppSharedPreferences.getString(SharedPreferencesKeys.name) ?? "";
    final String email =
        AppSharedPreferences.getString(SharedPreferencesKeys.email) ?? "";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Personal Info", style: AppStyles.body3Bold),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// NAME
              Text("Name", style: AppStyles.head3),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(name, style: AppStyles.body3),
              ),

              SizedBox(height: 22.h),

              /// EMAIL
              Text("E-Mail", style: AppStyles.head3),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(email, style: AppStyles.body3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
