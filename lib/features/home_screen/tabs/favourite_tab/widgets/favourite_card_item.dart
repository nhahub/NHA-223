import 'package:final_depi_project/utils/app_assets.dart';
import 'package:final_depi_project/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/app_styles.dart';

class FavouriteCardItem extends StatelessWidget {
  const FavouriteCardItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusGeometry.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackShadow,
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(AppAssets.shirtImage),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "T-shirt",
                      style: AppStyles.body2Black.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.star_rate_rounded, color: AppColors.goldenStar),
                    Text("4.4", style: AppStyles.descriptionBlack),
                  ],
                ),
                SizedBox(height: 4.h,),
                SizedBox(
                  width: 120.w,
                  child: Text(
                    "Lorem ipsum dolor sit amet consectetur.",
                    style: AppStyles.description,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: 8.h,),
                Row(
                  children: [
                    Text("\$50.00",style: AppStyles.body2Black.copyWith(fontWeight: FontWeight.bold),),
                    Spacer(),
                    SvgPicture.asset(AppAssets.favouriteIconSelected),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
