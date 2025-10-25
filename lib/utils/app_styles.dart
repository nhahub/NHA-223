import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppStyles{
  static TextStyle whiteBoldSize32Poppins=TextStyle(
    color: AppColors.whiteColor,
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    fontFamily: "Poppins"
  );

  static TextStyle agBody2Black=TextStyle(
    fontSize: 16,
    height: 1.4,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );
  static TextStyle head1 = TextStyle(
    fontSize: 24.sp,
    height: 1.4,
    color: Colors.black,
    fontWeight: FontWeight.w700,
  );

  static TextStyle head2 = TextStyle(
    fontSize: 22.sp,
    height: 1.4,
    color: Colors.black,
    fontWeight: FontWeight.w700,
  );

  static TextStyle head3 = TextStyle(
    fontSize: 20.sp,
    height: 1.4,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );

  static TextStyle body1 = TextStyle(
    fontSize: 18.sp,
    height: 1.4,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );

  static TextStyle body2Black = TextStyle(
    fontSize: 16.sp,
    height: 1.4,
    color: Colors.black,
  );
  static TextStyle body2grey = TextStyle(
    fontSize: 16.sp,
    height: 1.4,
    color: Colors.grey,
  );

  static TextStyle body3 = TextStyle(
    fontSize: 14.sp,
    height: 1.4,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );
  static TextStyle body3Bold = TextStyle(
    fontSize: 20.sp,
    height: 1.4,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static TextStyle description = TextStyle(
    fontSize: 12.sp,
    height: 1.4,
    color: Colors.grey,
    fontWeight: FontWeight.normal,
  );
  static TextStyle descriptionBlack = TextStyle(
    fontSize: 12.sp,
    height: 1.4,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );
  static TextStyle descriptionWhite = TextStyle(
    fontSize: 12.sp,
    height: 1.4,
    color: Colors.white,
    fontWeight: FontWeight.normal,
  );

}