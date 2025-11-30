import 'package:final_depi_project/features/home_screen/tabs/home_tab/widgets/category_widget.dart';
import 'package:final_depi_project/features/home_screen/tabs/home_tab/widgets/offer_card.dart';
import 'package:final_depi_project/features/home_screen/tabs/home_tab/widgets/offer_slider.dart';
import 'package:final_depi_project/features/home_screen/tabs/home_tab/widgets/search_field.dart';
import 'package:final_depi_project/utils/app_assets.dart';
import 'package:final_depi_project/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../category/category_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late List<CategoryWidget> categoriesList;

  @override
  Widget build(BuildContext context) {

    categoriesList = [
      CategoryWidget(
        icon: Icons.grid_view_rounded,
        label: 'All',
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const CategoryScreen()),
          );
        },
      ),
      CategoryWidget(
        icon: Icons.male,
        label: 'Mens',
        onPressed: () {},
      ),
      CategoryWidget(
        icon: Icons.female,
        label: 'Women',
        onPressed: () {},
      ),
      CategoryWidget(
        icon: Icons.style,
        label: 'Classic',
        onPressed: () {},
      ),
      CategoryWidget(
        icon: Icons.emoji_people,
        label: 'T-Shirt',
        onPressed: () {},
      ),
      CategoryWidget(
        icon: Icons.checkroom_rounded,
        label: 'Dress',
        onPressed: () {},
      ),
    ];

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
                  CircleAvatar(
                    radius: 22.w,
                    backgroundImage: AssetImage(AppAssets.orderPhoto),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hi, Ahmed', style: AppStyles.body2Black),
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
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey),
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(AppAssets.notificationIcon),
                  ),
                ],
              ),

              SizedBox(height: 32.h),
              const SearchField(),
              SizedBox(height: 32.h),
              const OffersSlider(),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: AppStyles.head3,
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              SizedBox(
                height: 70.h,
                child: ListView.separated(
                  itemBuilder: (context, index) => categoriesList[index],
                  separatorBuilder: (context, index) => SizedBox(width: 15.w),
                  itemCount: categoriesList.length,
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