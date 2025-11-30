import 'package:final_depi_project/features/category/presentaion/product_list_view.dart';
import 'package:final_depi_project/features/home_screen/tabs/home_tab/cubit/home_cubit.dart';
import 'package:final_depi_project/features/home_screen/tabs/home_tab/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key, required this.index});
  int index;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    final List<String> categories = cubit.categoriesNames;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        bool isLoading = state is ProductsLoading;
        return DefaultTabController(
          initialIndex: index,
          length: categories.length,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('Products'),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              foregroundColor: Colors.black,
              bottom: TabBar(
                tabAlignment: TabAlignment.start,
                padding: EdgeInsets.zero,
                isScrollable: true,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.black,
                tabs: categories
                    .map((category) => Tab(text: category))
                    .toList(),
              ),
            ),
            body: isLoading
                ? Center(child: CircularProgressIndicator())
                : TabBarView(
                    children: [
                      ProductsListView(productsList: cubit.allProducts),
                      ProductsListView(productsList: cubit.mens),
                      ProductsListView(productsList: cubit.women),
                      ProductsListView(productsList: cubit.electronics),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
