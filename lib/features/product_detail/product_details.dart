
import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_depi_project/features/address/address_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:final_depi_project/features/home_screen/tabs/cart_tab/cubit/cart_cubit.dart';
import 'package:final_depi_project/features/home_screen/tabs/cart_tab/cubit/cart_state.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

class ProductDetails extends StatefulWidget {
  final String productId;
  final String heroTag;
  final String productTitle;
  final String productImage;
  final double productPrice;
  final String? category;
  final String? brand;
  final double? ratingsAverage;
  final String? description;
  final List<String>? availableColors;
  final List<String>? availableSizes;

  const ProductDetails({
    super.key,
    required this.productId,
    required this.heroTag,
    required this.productTitle,
    required this.productImage,
    required this.productPrice,
    this.category,
    this.brand,
    this.ratingsAverage,
    this.description,
    this.availableColors,
    this.availableSizes,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String? selectedSize;
  String? selectedColor;

  bool _isAddingToCart = false;
  bool _isBuyingNow = false;
  bool _isProductInCart = false;

  @override
  void initState() {
    super.initState();
    _checkIfProductInCart();
  }

  void _checkIfProductInCart() {
    final cartCubit = context.read<CartCubit>();
    if (cartCubit.state is CartLoaded) {
      final cartState = cartCubit.state as CartLoaded;
      final isInCart = cartState.cart.items?.any(
              (item) => item.productId == widget.productId
      ) ?? false;
      setState(() {
        _isProductInCart = isInCart;
      });
    }
  }

  bool get _isClothingProduct {
    final category = widget.category?.toLowerCase() ?? '';
    return category.contains('clothing') ||
        category.contains('men\'s') ||
        category.contains('women\'s') ||
        category.contains('fashion') ||
        category.contains('t-shirt') ||
        category.contains('shirt') ||
        category.contains('pants') ||
        category.contains('jeans') ||
        category.contains('dress');
  }

  bool get _isShoesProduct {
    final category = widget.category?.toLowerCase() ?? '';
    return category.contains('shoes') ||
        category.contains('sneakers') ||
        category.contains('boots') ||
        category.contains('footwear');
  }

  bool get _isElectronicsProduct {
    final category = widget.category?.toLowerCase() ?? '';
    return category.contains('electronics') ||
        category.contains('mobile') ||
        category.contains('laptop') ||
        category.contains('headphone') ||
        category.contains('watch') ||
        category.contains('gadget');
  }

  List<String> get _sizes {
    if (widget.availableSizes != null && widget.availableSizes!.isNotEmpty) {
      return widget.availableSizes!;
    }

    if (_isClothingProduct) {
      return ['S', 'M', 'L', 'XL', 'XXL'];
    }
    if (_isShoesProduct) {
      return ['36', '38', '40', '42', '44'];
    }
    return [];
  }

  List<String> get _colors {
    if (widget.availableColors != null && widget.availableColors!.isNotEmpty) {
      return widget.availableColors!;
    }

    if (_isClothingProduct || _isElectronicsProduct) {
      return ['Black', 'White', 'Blue', 'Red', 'Gray'];
    }
    return [];
  }

  bool get _needsSizeSelection {
    return _sizes.isNotEmpty;
  }

  bool get _needsColorSelection {
    return _colors.isNotEmpty;
  }

  String get _productDescription {
    if (widget.description != null && widget.description!.isNotEmpty) {
      return widget.description!;
    }

    if (_isClothingProduct) {
      return 'Premium quality fabric with comfortable fit. Perfect for everyday wear. Machine washable and durable material that maintains its shape and color after multiple washes.';
    } else if (_isShoesProduct) {
      return 'Comfortable and stylish footwear designed for all-day wear. Features cushioned insole and breathable materials. Durable construction with excellent grip and support.';
    } else if (_isElectronicsProduct) {
      return 'Latest technology with advanced features. High performance and reliability. Designed with modern aesthetics and user-friendly interface. Comes with warranty and customer support.';
    } else {
      return 'High quality product crafted with premium materials. Designed for comfort, durability, and style. Perfect addition to your collection with excellent value for money.';
    }
  }

  void _showSnackBar(BuildContext context, String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.error_outline,
              color: Colors.white,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        duration: const Duration(seconds: 2),
        margin: EdgeInsets.only(
          bottom: 80.h,
          left: 16.w,
          right: 16.w,
        ),
      ),
    );
  }

  Future<void> _toggleCart(BuildContext context) async {
    if (_isAddingToCart) return;

    // if (_needsSizeSelection && selectedSize == null) {
    //   _showSnackBar(context, 'Please select a size first', false);
    //   return;
    // }

    // if (_needsColorSelection && selectedColor == null) {
    //   _showSnackBar(context, 'Please select a color first', false);
    //   return;
    // }

    setState(() {
      _isAddingToCart = true;
    });

    try {
      final cartCubit = context.read<CartCubit>();

      if (_isProductInCart) {
        await cartCubit.removeItem(widget.productId);
        setState(() {
          _isProductInCart = false;
        });
        if (mounted) {
          _showSnackBar(context, 'Removed from cart', true);
        }
      } else {
        await cartCubit.addToCart(widget.productId);
        setState(() {
          _isProductInCart = true;
        });
        if (mounted) {
          _showSnackBar(context, 'Added to cart successfully!', true);
        }
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar(context, 'Failed. Try again.', false);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isAddingToCart = false;
        });
      }
    }
  }

  Future<void> _buyNow(BuildContext context) async {
    if (_isBuyingNow) return;

    if (_needsSizeSelection && selectedSize == null) {
      _showSnackBar(context, 'Please select a size first', false);
      return;
    }

    if (_needsColorSelection && selectedColor == null) {
      _showSnackBar(context, 'Please select a color first', false);
      return;
    }

    setState(() {
      _isBuyingNow = true;
    });

    try {
      if (mounted) {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddressScreen(total: widget.productPrice),)
        );
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar(context, 'Failed to process. Try again.', false);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isBuyingNow = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      height: 380.h,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 60.h),
                              child: Hero(
                                tag: widget.heroTag,
                                child: Material(
                                  color: Colors.transparent,
                                  child: CachedNetworkImage(
                                    imageUrl: widget.productImage,
                                    width: 260.w,
                                    height: 260.h,
                                    fit: BoxFit.contain,
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error_outline,
                                      size: 50.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            top: 16.h,
                            left: 16.w,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 20.sp,
                                  color: Colors.black,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: size.width,
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productTitle,
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              height: 1.3,
                            ),
                          ),

                          SizedBox(height: 12.h),

                          Row(
                            children: [
                              Text(
                                '\$${widget.productPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Spacer(),
                              if (widget.ratingsAverage != null) ...[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 6.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.amber.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 18.sp,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        widget.ratingsAverage!.toStringAsFixed(1),
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),

                          SizedBox(height: 24.h),

                          if (_needsColorSelection) ...[
                            Text(
                              'Select Color',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Wrap(
                              spacing: 10.w,
                              runSpacing: 10.h,
                              children: _colors.map((color) {
                                final isSelected = selectedColor == color;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedColor = color;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 10.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected ? Colors.black : Colors.white,
                                      border: Border.all(
                                        color: isSelected ? Colors.black : Colors.grey[300]!,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Text(
                                      color,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 20.h),
                          ],

                          if (_needsSizeSelection) ...[
                            Text(
                              _isShoesProduct ? 'Select Shoe Size' : 'Select Size',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Wrap(
                              spacing: 10.w,
                              runSpacing: 10.h,
                              children: _sizes.map((sizeText) {
                                final isSelected = selectedSize == sizeText;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedSize = sizeText;
                                    });
                                  },
                                  child: Container(
                                    width: 55.w,
                                    height: 55.h,
                                    decoration: BoxDecoration(
                                      color: isSelected ? Colors.black : Colors.white,
                                      border: Border.all(
                                        color: isSelected ? Colors.black : Colors.grey[300]!,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        sizeText,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: isSelected ? Colors.white : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 20.h),
                          ],

                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            _productDescription,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[700],
                              height: 1.6,
                            ),
                          ),

                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                bool isInCart = false;

                if (state is CartLoaded) {
                  isInCart = state.cart.items?.any(
                          (item) => item.productId == widget.productId
                  ) ?? false;
                }

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      children: [
                        // زر Buy Now
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _isBuyingNow ? null : () => _buyNow(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isBuyingNow
                                  ? Colors.grey[300]
                                  : Colors.black,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              elevation: 0,
                            ),
                            child: _isBuyingNow
                                ? SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                                : Text(
                              "Buy Now",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 12.w),

                        // زر Add to Cart
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _isAddingToCart ? null : () => _toggleCart(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isAddingToCart
                                  ? Colors.grey[300]
                                  : isInCart ? Colors.red : Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              side: BorderSide(
                                color: isInCart ? Colors.red : Colors.black,
                                width: 1.5,
                              ),
                              elevation: 0,
                            ),
                            child: _isAddingToCart
                                ? SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: isInCart ? Colors.white : Colors.black,
                              ),
                            )
                                : Text(
                              isInCart ? "Remove" : "Add to Cart",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: isInCart ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
