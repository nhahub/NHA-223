import 'package:final_depi_project/features/auth/cubit/auth_cubit.dart';
import 'package:final_depi_project/features/home_screen/tabs/home_tab/cubit/home_cubit.dart';
import 'package:final_depi_project/features/home_screen/tabs/home_tab/peresentaion/widgets/offer_card.dart';
import 'package:final_depi_project/features/home_screen/tabs/home_tab/peresentaion/widgets/offer_slider.dart';
import 'package:final_depi_project/features/home_screen/tabs/home_tab/peresentaion/widgets/search_field.dart';
import 'package:final_depi_project/features/category/presentaion/products_Screen.dart';
import 'package:final_depi_project/utils/app_assets.dart';
import 'package:final_depi_project/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/shared_prefrences.dart';


class HomeTab extends StatefulWidget {
  const HomeTab({super.key});


  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    print("this is my name${AppSharedPreferences.getString(SharedPreferencesKeys.name)}");
    final theme = Theme.of(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => context.read<HomeCubit>().getProductById("6428ebc6dc1175abc65ca0b9"),
                    child: CircleAvatar(
                      radius: 22.w,
                      backgroundImage: AssetImage(AppAssets.orderPhoto),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hi, ${AppSharedPreferences.getString(SharedPreferencesKeys.name) ??"Karas"}', style: AppStyles.body2Black),
                        SizedBox(height: 2.h),
                        Text(
                          'Happy Day',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              OffersSlider(),
              SizedBox(height: 32.h),
              Row(
                children: [
                  Text(
                    'Categories',
                    style:AppStyles.head3
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              SizedBox(
                height: 70.h,
                child: ListView.separated(
                  itemBuilder:(context, index) {
                    return InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsScreen(index: index,),)),
                        child: context.read<HomeCubit>().categoriesList[index]);
                  }  ,
                  separatorBuilder: (context, index) => SizedBox(width: 15.w,),
                  itemCount: context.read<HomeCubit>().categoriesList.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),

              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Offers & Discounts',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
                childAspectRatio: 160.w / 130.h,
                children: const [
                  OfferCard(
                    image:
                    'https://images.pexels.com/photos/3771674/pexels-photo-3771674.jpeg?auto=compress&cs=tinysrgb&w=800',
                    tag: '50% Offer',
                    title: 'Dress Children',
                    rating: 4.4,
                  ),
                  OfferCard(
                    image:
                    'https://images.pexels.com/photos/7679720/pexels-photo-7679720.jpeg?auto=compress&cs=tinysrgb&w=800',
                    tag: '30% Off',
                    title: 'T-shirt',
                    rating: 4.6,
                  ),
                ],
              ),

              SizedBox(height: 120.h), // space for custom bottom bar
            ],
          ),
        ),
      ),
    );
  }
}





