import 'package:final_depi_project/features/home_screen/tabs/cart_tab/cart_tab.dart';
import 'package:final_depi_project/features/home_screen/tabs/favourite_tab/presentation/favourite_tab.dart';
import 'package:final_depi_project/features/home_screen/tabs/home_tab/peresentaion/home_tab.dart';
import 'package:final_depi_project/features/home_screen/tabs/orders_tab/screens/track_order_screen.dart';
import 'package:final_depi_project/features/home_screen/tabs/profile_tab/profile_tab.dart';
import 'package:final_depi_project/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> tabs = [];

  int index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabs.addAll([
      HomeTab(),
      CartTab(),
      FavouriteTab(),
      ProfileScreen(
        onNavigate: (String target) {
          if (target == 'cart') {
            setState(() => index = 1);
          } else if (target == 'favourite') {
            setState(() => index = 2);
          }
        },
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
        ),
        margin: EdgeInsets.only(bottom: 24.h, left: 16.w, right: 16.w),
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(16.r),
          child: BottomNavigationBar(
            enableFeedback: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.black,
            currentIndex: index,
            onTap: (i) {
              setState(() {
                index = i;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppAssets.homeIcon),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppAssets.cartIcon),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppAssets.favouriteIcon),
                label: 'Favourite',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppAssets.profileIcon),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
      body: tabs[index],
    );
  }
}
