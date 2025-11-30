import 'package:final_depi_project/core/shared_prefrences.dart';
import 'package:final_depi_project/features/home_screen/tabs/favourite_tab/cubit/fav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../helpers/routes.dart';
import '../../home_screen/tabs/cart_tab/LocalCartService.dart';
import '../cubit/ProductsStates.dart';
import '../cubit/productcubit.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ScrollController _scrollController = ScrollController();
  final Set<String> _addingToCart = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductsCubit>().loadAllProducts();
    });

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ProductsCubit>().loadMoreProducts();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12.w),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _addToCart(Map<String, dynamic> product) async {
    final productId = product['_id'] ?? product['id'] ?? '';

    if (_addingToCart.contains(productId)) return;

    setState(() {
      _addingToCart.add(productId);
    });

    try {
      await LocalCartService.addToCart(product);

      if (mounted) {
        _showSuccessSnackBar(
          context,
          '${product['title'] ?? 'Product'} added to cart!',
        );
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar(context, 'Failed to add to cart');
      }
    } finally {
      if (mounted) {
        setState(() {
          _addingToCart.remove(productId);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
          if (state is ProductsError) {
            _showErrorSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                // Header Section
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.black,
                              size: 22.sp,
                            ),
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).pushNamed(Routes.homeScreen);
                            },
                          ),
                          Text(
                            "All Products",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 22.sp,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Content Section
                Expanded(child: _buildContent(state)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(ProductsState state) {
    if (state is ProductsLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: const Color(0xFF070707),
          strokeWidth: 3.w,
        ),
      );
    }

    if (state is ProductsEmpty) {
      return _buildEmptyProducts();
    }

    if (state is ProductsLoaded) {
      return _buildProductsGrid(state.products, state.hasMore);
    }

    if (state is ProductsError) {
      return _buildErrorState(state);
    }

    return const SizedBox();
  }

  Widget _buildProductsGrid(List<dynamic> products, bool hasMore) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<ProductsCubit>().refreshProducts();
      },
      color: const Color(0xFF0B0B0B),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: GridView.builder(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 0.7,
          ),
          itemCount: hasMore ? products.length + 2 : products.length,
          itemBuilder: (context, index) {
            if (index >= products.length) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: CircularProgressIndicator(
                    color: const Color(0xFF070707),
                    strokeWidth: 2.w,
                  ),
                ),
              );
            }
            final product = products[index];
            return _buildProductItem(product);
          },
        ),
      ),
    );
  }

  Widget _buildProductItem(Map<String, dynamic> product) {
    final productId = product['_id'] ?? product['id'] ?? '';
    final isAdding = _addingToCart.contains(productId);

    return BlocBuilder<FavCubit, FavState>(
      builder: (context, state) {
        final favCubit = FavCubit.get(context);
        final isFavorite = favCubit.isProductInFavorites(productId);

        return Material(
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.white,
          elevation: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Stack(
              children: [
                // Product Image
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    image: DecorationImage(
                      image: NetworkImage(product['imageCover'] ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Gradient Overlay for text readability
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),

                // Favorite Button
                Positioned(
                  top: 8.w,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: () async {
                      final token = await AppSharedPreferences.getString(
                        SharedPreferencesKeys.token,
                      );
                      if (token != null && productId.isNotEmpty) {
                        favCubit.toggleFavorite(productId, token);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.black,
                        size: 16.sp,
                      ),
                    ),
                  ),
                ),

                // Product Details at bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['title'] ?? 'No Title',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.h),
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
                                  '${product['ratingsAverage'] ?? '0.0'}',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
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
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                "\$${product['price']?.toString() ?? '0'}",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            SizedBox(width: 8.w),

                            // Add to Cart Button
                            GestureDetector(
                              onTap: isAdding
                                  ? null
                                  : () => _addToCart(product),
                              child: Container(
                                padding: EdgeInsets.all(6.w),
                                decoration: BoxDecoration(
                                  color: isAdding
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
                                child: isAdding
                                    ? SizedBox(
                                        width: 14.sp,
                                        height: 14.sp,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyProducts() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 80.sp,
            color: Colors.grey[300],
          ),
          SizedBox(height: 16.h),
          Text(
            'No products found',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Start shopping to see products here',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(ProductsError state) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64.sp, color: Colors.red[300]),
            SizedBox(height: 16.h),
            Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              state.message,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () {
                context.read<ProductsCubit>().loadAllProducts();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A0A0A),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Try Again',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
