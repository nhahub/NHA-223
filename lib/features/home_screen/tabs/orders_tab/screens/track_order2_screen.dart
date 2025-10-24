// ignore_for_file: must_be_immutable

import 'package:final_depi_project/features/home_screen/tabs/orders_tab/widgets/order_process_card_widget.dart';
import 'package:final_depi_project/helpers/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackOrderScreen2 extends StatelessWidget {
  String? orderId;
  String? orderdate;
  TrackOrderScreen2({super.key, this.orderId, this.orderdate});

  @override
  Widget build(BuildContext context) {
    orderId = "04555174";
    orderdate = "Wed, 15, june 2020, 11:35 PM";
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "T-Shirt",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, Routes.trackorder);
          },
          icon: Icon(Icons.arrow_back_ios, size: 24.sp, color: Colors.white),
        ),
      ),

      body: Center(
        child: Column(
          children: [
            //!-------------------------------------------------------"stack"
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity.w,
                  height: 57.h,
                  color: Colors.black,
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    width: 343.w,
                    // height: 114.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Color(0xFFFAFAFA),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 18.h),
                        SizedBox(
                          width: 189.w,

                          // height: 28.h,
                          child: Text(
                            "Order ID :$orderId",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 18.h),
                        Center(
                          child: SizedBox(
                            width: 222.w,

                            // height: 22,
                            child: Text(
                              "$orderdate",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF8E8E8E),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 18.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            //!-----------------------------------------------"order process"
            SizedBox(height: 126.h),
            SizedBox(
              width: 343.w,
              child: OrderProgressCard(
                deliveryBy: 'Ahmed',
                arrivalText: 'Friday 12 Dec , 2025 By 8.00 Pm',
                currentStep: 2, // 0..4
                updatedText: 'Updated: 10 min ago',
              ),
            ),

            //!-----------------------------------------------"order cancel"
            SizedBox(height: 228.h),
            SizedBox(
              width: 343.w,
              height: 40.h,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, Routes.trackorder);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 1, color: Colors.red),
                  ),
                  child: Center(
                    child: Text(
                      "Cancel Order",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
