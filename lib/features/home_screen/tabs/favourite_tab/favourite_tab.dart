import 'package:final_depi_project/features/home_screen/tabs/favourite_tab/widgets/favourite_card_item.dart';
import 'package:final_depi_project/features/product_detail/product_details.dart';
import 'package:final_depi_project/helpers/routes.dart';
import 'package:final_depi_project/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavouriteTab extends StatelessWidget {
  const FavouriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Favourite',
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Poppins",
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context,Routes.productDetails );
              },
              child: FavouriteCardItem());
        },
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemCount: 10,
      ),
    );
  }
}

