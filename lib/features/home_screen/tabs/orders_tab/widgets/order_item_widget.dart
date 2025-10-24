// ignore_for_file: sized_box_for_whitespace, sort_child_properties_last

import 'package:final_depi_project/helpers/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderItemWidget extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final String? photoUrl; // optional photo URL
  final String? orderId;
  const OrderItemWidget({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    this.photoUrl,
    this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 150.h,
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(width: 0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //! Image
          SizedBox(width: 16.w),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: (photoUrl == null || photoUrl!.isEmpty)
                ? Image.asset(
                    'assets/images/orderphoto2.png',
                    width: 118.w,
                    height: 118.h,
                    fit: BoxFit.fill,
                  )
                : Image.network(
                    photoUrl!,
                    width: 110.w,
                    height: 110.h,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/Goggle.png',
                        width: 118.w,
                        height: 118.h,
                        fit: BoxFit.fill,
                      );
                    },
                  ),
          ),

          SizedBox(width: 8.w),

          //! Column (title, description, time)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 6.h),
              SizedBox(
                width: 137.w,
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Color(0xFF9E9E9E),
                    fontWeight: FontWeight.w400,
                    height: 1.3.h,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                time,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(width: 8.w),
          //! Arrow button
          SizedBox(
            width: 40.w,
            height: 40.h,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.trackorder2);
              },
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 15.5.w),
        ],
      ),
    );
  }
}
