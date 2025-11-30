import 'package:final_depi_project/features/products_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_screen/tabs/home_tab/cubit/home_cubit.dart';
import 'home_screen/tabs/home_tab/data/model/get_all_product_response.dart' show Product;

class ProductsListView extends StatelessWidget {
  ProductsListView({
    super.key,
    required this.productsList
  });
  List<Product> productsList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: RefreshIndicator(
        onRefresh: () => context.read<HomeCubit>().fetchProducts(),
        child: GridView.builder(
          itemCount: productsList.length, // Placeholder count
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 160 / 210,
          ),
          itemBuilder: (context, index) {
            return ProductsCard(product: productsList[index],);
          },
        ),
      ),
    );
  }
}

