import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_styles.dart';
import '../data/models/cart_item.dart';
import 'item_counter.dart';

class CartItemCard extends StatelessWidget {
  CartItemCard({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onDelete,
    required this.onEdit,
  });

  final CartItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFEFEFEF)),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  item.image,
                  width: 118.w,
                  height: 118.h,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 15.w,
                bottom: -10.h,
                child: ItemCounter(
                  qty: item.qty,
                  onMinus: onDecrease,
                  onPlus: onIncrease,
                ),
              ),
            ],
          ),
          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(item.title, style: AppStyles.body2Black),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  'Lorem ipsum dolor amet consectetur.',
                  style: AppStyles.description,
                ),
                SizedBox(height: 8.w),
                Row(
                  children: [
                    Text(
                      'Color : ${item.color}',
                      style: AppStyles.descriptionBlack,
                    ),
                    Spacer(),
                    Text(
                      'Size : ${item.size}',
                      style: AppStyles.descriptionBlack,
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  '\$${item.price.toStringAsFixed(2)}',
                  style: AppStyles.body2Black.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 6.w),

          InkWell(
            onTap: onDelete,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              decoration: BoxDecoration(
                color: Color(0xFFFFF1F1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                CupertinoIcons.delete,
                size: 18.sp,
                color: Color(0xFFFF5A5F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
