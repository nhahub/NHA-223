import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../product_detail/product_details.dart';
import '../../../../product_detail/service/product_selection_service.dart';
import '../data/models/CartItemModel.dart';
import 'item_counter.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
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
              GestureDetector(
                onTap: () => _navigateToProductDetails(context),
                child: Hero(
                  tag: 'cart-item-image-${item.productId}',
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: 118.w,
                      height: 118.h,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: _buildProductImage(),
                      ),
                    ),
                  ),
                ),
              ),

              // Counter positioned over image
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
                // Product Title
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),

                // Color and Size - ✅ عرض الخيارات المختارة
                if (item.color != null || item.size != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.color != null && item.color!.isNotEmpty)
                        Text(
                          'Color: ${item.color}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[700],
                            fontFamily: "Poppins",
                          ),
                        ),
                      if (item.size != null && item.size!.isNotEmpty)
                        Text(
                          'Size: ${item.size}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[700],
                            fontFamily: "Poppins",
                          ),
                        ),
                      SizedBox(height: 4.h),
                    ],
                  ),

                SizedBox(height: 6.h),

                // Price
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

          // Delete Button
          InkWell(
            onTap: onDelete,
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF1F1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                CupertinoIcons.delete,
                size: 18.sp,
                color: const Color(0xFFFF5A5F),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToProductDetails(BuildContext context) async {
    final selections = await ProductSelectionService.loadProductSelection(item.productId ?? '');

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ProductDetails(
          productId: item.productId ?? '',
          heroTag: 'cart-item-image-${item.productId}',
          productTitle: item.productTitle,
          productImage: item.imageUrl,
          productPrice: item.priceDouble,
          // ✅ تمرير الخيارات المختارة
          availableSizes: selections['size'] != null ? [selections['size']!] : null,
          availableColors: selections['color'] != null ? [selections['color']!] : null,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.1);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;

          var tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  Widget _buildProductImage() {
    final imageUrl = item.imageUrl;

    if (imageUrl.isEmpty) {
      return Icon(
        Icons.shopping_bag,
        size: 40.sp,
        color: Colors.grey[400],
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.black,
        ),
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.error_outline,
        size: 40.sp,
        color: Colors.grey[400],
      ),
    );
  }
}