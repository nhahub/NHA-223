/*

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../helpers/routes.dart';
import '../cubit/cart_cubit.dart';


Widget buildErrorWidget(
    BuildContext context,
    String message, {
      bool isAuthError = false,
    }) {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isAuthError ? Icons.login : Icons.error_outline,
            size: 80.sp,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF070707),
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              if (isAuthError) {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.signinScreen,
                );
              } else {
                context.read<CartCubit>().refreshCart();
              }
            },
            child: Text(
              isAuthError ? 'Go to Login' : 'Retry',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}*/