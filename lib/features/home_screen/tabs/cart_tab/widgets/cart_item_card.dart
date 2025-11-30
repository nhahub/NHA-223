import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/models/CartItemModel.dart';
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
              // صورة المنتج
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  width: 118.w,
                  height: 118.h,
                  color: Colors.grey[200],
                  child: _buildProductImage(),
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
                      child: Text(
                        item.productTitle,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),

                Row(
                  children: [
                    Text(
                      'Color : ${item.productColor}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[700],
                        fontFamily: "Poppins",
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Size : ${item.productSize}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[700],
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  '\$${item.priceDouble.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "Poppins",
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

  Widget _buildProductImage() {
    final imageUrl = item.imageUrl;

    print('🖼️ Loading image for product: ${item.productId}');
    print('🖼️ Image URL: $imageUrl');

    if (imageUrl.isEmpty) {
      print('⚠️ No image URL available, showing placeholder');
      return Icon(
        Icons.shopping_bag,
        size: 40.sp,
        color: Colors.grey[400],
      );
    }

    // استخدام CachedNetworkImage بدلاً من Image.network
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.black,
        ),
      ),
      errorWidget: (context, url, error) {
        print('❌ Error loading image: $error');
        return Icon(
          Icons.error_outline,
          size: 40.sp,
          color: Colors.grey[400],
        );
      },
    );
  }
}