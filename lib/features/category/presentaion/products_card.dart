import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_depi_project/core/shared_prefrences.dart';
import 'package:final_depi_project/features/home_screen/tabs/favourite_tab/cubit/fav_cubit.dart';
import 'package:final_depi_project/features/home_screen/tabs/cart_tab/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../home_screen/tabs/home_tab/data/model/get_all_product_response.dart';

class ProductsCard extends StatelessWidget {
  ProductsCard({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavCubit, FavState>(
      builder: (context, state) {
        final favCubit = FavCubit.get(context);
        final isFavorite = favCubit.isProductInFavorites(product.id ?? '');

        return TweenAnimationBuilder(
          duration: const Duration(milliseconds: 500),
          tween: Tween<double>(begin: 0.9, end: 1.0),
          curve: Curves.easeOutBack,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: TweenAnimationBuilder(
                duration: const Duration(milliseconds: 400),
                tween: Tween<double>(begin: 0.0, end: 1.0),
                curve: Curves.easeIn,
                builder: (context, opacity, child) {
                  return Opacity(
                    opacity: opacity,
                    child: child,
                  );
                },
                child: _buildCardContent(context, favCubit, isFavorite),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCardContent(BuildContext context, FavCubit favCubit, bool isFavorite) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.w,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Product Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: CachedNetworkImage(
                imageUrl: product.imageCover ?? product.images?[0] ?? "",
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.black,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.error_outline,
                    color: Colors.grey[400],
                    size: 40.sp,
                  ),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),

          // Favorite Button
          Positioned(
            top: 8.w,
            right: 8.w,
            child: _FavoriteButton(
              product: product,
              isFavorite: isFavorite,
              favCubit: favCubit,
            ),
          ),

          // Product Info
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title
                  Text(
                    product.title ?? "",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1.2,
                      fontFamily: "Poppins",
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),

                  // Rating, Price and Add to Cart
                  Row(
                    children: [
                      // Rating
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 12.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            product.ratingsAverage?.toStringAsFixed(1) ?? "0.0",
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),

                      // Price
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          "${product.price}\$",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),

                      // Add to Cart Button
                      _AddToCartButton(product: product),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteButton extends StatefulWidget {
  final Product product;
  final bool isFavorite;
  final FavCubit favCubit;

  const _FavoriteButton({
    required this.product,
    required this.isFavorite,
    required this.favCubit,
  });

  @override
  State<_FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<_FavoriteButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    if (_isAnimating) return;

    setState(() {
      _isAnimating = true;
    });

    await _animationController.forward(from: 0.0);
    await _animationController.reverse();

    final token = await AppSharedPreferences.getString(
      SharedPreferencesKeys.token,
    );
    if (token != null && widget.product.id != null) {
      widget.favCubit.toggleFavorite(widget.product.id!, token);
    }

    setState(() {
      _isAnimating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _animationController.drive(
          Tween<double>(begin: 1.0, end: 1.2).chain(
            CurveTween(curve: Curves.easeInOut),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4.w,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          child: Icon(
            widget.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: widget.isFavorite ? Colors.red : Colors.black,
            size: 16.sp,
          ),
        ),
      ),
    );
  }
}

// 🔥 الكلاس المعدل بالكامل
class _AddToCartButton extends StatefulWidget {
  final Product product;

  const _AddToCartButton({required this.product});

  @override
  State<_AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<_AddToCartButton> with SingleTickerProviderStateMixin {
  bool _isAddingToCart = false;
  late AnimationController _successAnimationController;

  @override
  void initState() {
    super.initState();
    _successAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _successAnimationController.dispose();
    super.dispose();
  }

  Future<void> _handleAddToCart() async {
    if (_isAddingToCart) return;

    setState(() {
      _isAddingToCart = true;
    });

    try {
      final cartCubit = context.read<CartCubit>();

      // 🔥 الـ Cubit هيعمل الإضافة والـ refresh تلقائياً
      await cartCubit.addToCart(widget.product.id ?? '');

      // Animation للنجاح
      await _successAnimationController.forward(from: 0.0);
      await _successAnimationController.reverse();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    '${widget.product.title} added to cart!',
                    style: TextStyle(fontFamily: "Poppins"),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: 'View Cart',
              textColor: Colors.white,
              onPressed: () {
                // يمكن الانتقال للكارت هنا
                // Navigator.pushNamed(context, Routes.cartTab);
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Failed to add to cart. Please try again.',
                    style: TextStyle(fontFamily: "Poppins"),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
      print('❌ Error adding to cart: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isAddingToCart = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isAddingToCart ? null : _handleAddToCart,
      child: ScaleTransition(
        scale: _successAnimationController.drive(
          Tween<double>(begin: 1.0, end: 1.3).chain(
            CurveTween(curve: Curves.easeInOut),
          ),
        ),
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 200),
          tween: Tween<double>(begin: 1.0, end: _isAddingToCart ? 0.8 : 1.0),
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: _isAddingToCart
                  ? Colors.grey.withOpacity(0.5)
                  : Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4.w,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: _isAddingToCart
                ? SizedBox(
              width: 14.sp,
              height: 14.sp,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.black,
                ),
              ),
            )
                : Icon(
              Icons.add_shopping_cart,
              color: Colors.black,
              size: 14.sp,
            ),
          ),
        ),
      ),
    );
  }
}