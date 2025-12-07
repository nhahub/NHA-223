import 'package:final_depi_project/features/category/presentaion/products_Screen.dart';
import 'package:final_depi_project/features/home_screen/tabs/cart_tab/widgets/add_minus_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../helpers/routes.dart';

Widget buildEmptyCart(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.shopping_cart_outlined,
            size: 100.sp, color: Colors.grey[300]),
        SizedBox(height: 16.h),
        Text('Your cart is empty',
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600])),
        SizedBox(height: 24.h),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
            side: BorderSide(color: Color(0xFF0A0A0A), width: 1.4),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () =>
              Navigator.push(context,MaterialPageRoute(builder: (context) => ProductsScreen(index: 0),)) ,
          child: Text('Start Shopping',
              style: TextStyle(
                  color: Color(0xFF0A0A0A), fontWeight: FontWeight.w600)),
        ),
      ],
    ),
  );
}
