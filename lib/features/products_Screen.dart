import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_depi_project/features/category/cubit/productcubit.dart';
import 'package:final_depi_project/features/home_screen/tabs/home_tab/cubit/home_cubit.dart';
import 'package:final_depi_project/features/home_screen/tabs/home_tab/cubit/home_state.dart';
import 'package:final_depi_project/features/home_screen/tabs/home_tab/data/model/get_all_product_response.dart';
import 'package:final_depi_project/features/product_list_view.dart';
import 'package:final_depi_project/features/products_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_screen/tabs/home_tab/peresentaion/widgets/category_widget.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit=context.read<HomeCubit>();
    final List<String> categories = cubit.categoriesNames;
    return BlocBuilder<HomeCubit,HomeState>(
      builder: (context, state) {
        bool isLoading=state is ProductsLoading;
        return DefaultTabController(
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
                tabs: categories.map((category) => Tab(text: category)).toList(),
              ),
            ),
            body: isLoading?
            Center(child: CircularProgressIndicator(),)
            :TabBarView(
                children: [
                  ProductsListView(productsList: cubit.allProducts,),
                  ProductsListView(productsList: cubit.mens,),
                  ProductsListView(productsList: cubit.women,),
                  ProductsListView(productsList: cubit.electronics,),
                ]
            ),
          ),
        );


      }
    );
  }
}





