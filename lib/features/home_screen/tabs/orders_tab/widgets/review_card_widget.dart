// ignore_for_file: sized_box_for_whitespace, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewCard extends StatelessWidget {
  final String name;
  final String date;
  final String review;
  final int rating;
  final String? photoUrl; // optional photo URL

  const ReviewCard({
    super.key,
    required this.name,
    required this.date,
    required this.review,
    required this.rating,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 109.h,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          //! row (photo + column[name + date]  + rate (star icon + rate))
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 16.w),
              //! photo + column[name + date]
              Container(
                width: 36.h,
                height: 36.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: (photoUrl == null || photoUrl!.isEmpty)
                      ? Image.asset(
                          'assets/images/photo2.png',
                          width: 36.w,
                          height: 36.h,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          photoUrl!,
                          width: 36.w,
                          height: 36.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/photo2.png',
                              width: 36.w,
                              height: 36.h,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF9C9C9C),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 174.w),
              //! rate (star icon + rate)
              Row(
                children: [
                  Icon(Icons.star, color: Color(0xFFFFC107), size: 12.sp),
                  SizedBox(width: 4.w),
                  Text(
                    rating.toString(),
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),

          //! row (comment)
          Row(
            children: [
              SizedBox(width: 47.w),
              Text(
                review,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
