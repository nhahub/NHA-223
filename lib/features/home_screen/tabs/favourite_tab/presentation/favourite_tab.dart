import 'package:final_depi_project/core/shared_prefrences.dart';
import 'package:final_depi_project/features/category/presentaion/products_Screen.dart';
import 'package:final_depi_project/features/home_screen/tabs/favourite_tab/cubit/fav_cubit.dart';
import 'package:final_depi_project/features/home_screen/tabs/favourite_tab/data/model/allfav_response.dart';
import 'package:final_depi_project/features/home_screen/tabs/favourite_tab/presentation/widgets/favourite_card_item.dart';
import 'package:final_depi_project/features/product_detail/product_details.dart';
import 'package:final_depi_project/helpers/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteTab extends StatefulWidget {
  const FavouriteTab({super.key});

  @override
  State<FavouriteTab> createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavouriteTab> {
  String? token;
  late FavCubit _favCubit;

  @override
  void initState() {
    super.initState();
    _favCubit = FavCubit.get(context);
    _getTokenAndLoadFavorites();
  }

  Future<void> _getTokenAndLoadFavorites() async {
    token = await AppSharedPreferences.getString(SharedPreferencesKeys.token);
    if (token != null && token!.isNotEmpty) {
      _favCubit.getAllFavorites(token!);
    } else {
      _favCubit.emit(FavError("Connection Error"));
    }
  }

  Future<void> _refreshFavorites() async {
    if (token != null && token!.isNotEmpty) {
      await _favCubit.getAllFavorites(token!);
    } else {
      await _getTokenAndLoadFavorites();
    }
  }

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
        elevation: 0,
      ),
      body: BlocConsumer<FavCubit, FavState>(
        listener: (context, state) {
          if (state is FavError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          } else if (state is FavSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          final currentFavorites = _favCubit.favorites;

          if (state is FavLoading && currentFavorites.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AllFavLoaded ||
              state is FavSuccess ||
              currentFavorites.isNotEmpty) {
            if (currentFavorites.isEmpty) {
              return _buildEmptyState();
            }
            return _buildFavoritesList(currentFavorites);
          } else if (state is FavError) {
            return _buildErrorState(state.error);
          } else {
            // Default case - show loading
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildFavoritesList(List<WishlistProduct> favorites) {
    return RefreshIndicator(
      onRefresh: _refreshFavorites,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: ListView.separated(
          itemBuilder: (context, index) {
            final product = favorites[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) {
                  return ProductDetails(productId: product.id,
                      heroTag: 'product-${product.id}',
                      productTitle: product.title,
                      productImage: product.imageCover?? product.images[0],
                      productPrice: product.price.toDouble())
                  ;
                },));
              },
              child: FavouriteCardItem(
                product: product,
                onRemove: () {
                  if (token != null) {
                    _favCubit.removeFromFavorites(product.id, token!);
                  }
                },
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemCount: favorites.length,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80.w, color: Colors.grey[400]),
          SizedBox(height: 16.h),
          Text(
            'No Favorites Yet',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Start adding products to your wishlist',
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: "Poppins",
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: _refreshFavorites,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
            child: Text(
              'Refresh',
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: "Poppins",
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80.w, color: Colors.red),
          SizedBox(height: 16.h),
          Text(
            'Something Went Wrong',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
              color: Colors.red,
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: "Poppins",
                color: Colors.grey[600],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: _refreshFavorites,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
            child: Text(
              'Try Again',
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: "Poppins",
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
