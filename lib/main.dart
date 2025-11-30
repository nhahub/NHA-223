import 'package:final_depi_project/core/bloc_observer.dart';
import 'package:final_depi_project/core/dio_helper.dart';
import 'package:final_depi_project/core/payment.dart';
import 'package:final_depi_project/core/shared_prefrences.dart';
import 'package:final_depi_project/features/auth/presentaion/sign_in_screen.dart';
import 'package:final_depi_project/features/auth/presentaion/sign_up_screen.dart';
import 'package:final_depi_project/features/category/category_screen.dart';
import 'package:final_depi_project/features/home_screen/home_screen.dart';
import 'package:final_depi_project/features/home_screen/tabs/favourite_tab/cubit/fav_cubit.dart';
import 'package:final_depi_project/features/home_screen/tabs/favourite_tab/data/repo/fav_repo.dart';
import 'package:final_depi_project/features/home_screen/tabs/home_tab/home_tab.dart';
import 'package:final_depi_project/features/home_screen/tabs/orders_tab/screens/review_screen.dart';
import 'package:final_depi_project/features/home_screen/tabs/orders_tab/screens/track_order2_screen.dart';
import 'package:final_depi_project/features/home_screen/tabs/orders_tab/screens/track_order_screen.dart';
import 'package:final_depi_project/features/home_screen/tabs/profile_tab/edit_profile_screen.dart';
import 'package:final_depi_project/features/home_screen/tabs/profile_tab/profile_tab.dart';
import 'package:final_depi_project/features/onboarding/onbourdingmain.dart';
import 'package:final_depi_project/features/product_detail/product_details.dart';
import 'package:final_depi_project/features/splash_screen.dart';
import 'package:final_depi_project/firebase_options.dart';
import 'package:final_depi_project/helpers/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/auth/cubit/auth_cubit.dart';
import 'features/auth/data/repo/auth_repo.dart';
import 'features/category/category_screen.dart';
import 'features/category/cubit/productcubit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.init();
  Bloc.observer = MyBlocObserver();
  // await SharedPreferences.getInstance();
  DioHelper.init(baseUrl: "https://ecommerce.routemisr.com/api/v1");

  Payment.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => AuthCubit(AuthRepository())),
        BlocProvider<FavCubit>(create: (context) => FavCubit(FavRepo())),
    BlocProvider<ProductsCubit>(
    create: (context) => ProductsCubit(),


      )],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          initialRoute: Routes.categoryScreen,
          routes: {
            Routes.signupScreen: (context) => SignUpScreen(),
            Routes.categoryScreen:(context)=>CategoryScreen(),
            Routes.signinScreen: (context) => SignInScreen(),
            Routes.reviewScreen: (context) => ReviewScreen(),
            Routes.trackorder: (context) => TrackOrderScreen(),
            Routes.trackorder2: (context) => TrackOrderScreen2(),
            Routes.homeTab: (context) => HomeTab(),
            Routes.onboardingMain: (context) => OnboardingMain(),
            Routes.productDetails: (context) => ProductDetails(),
            Routes.homeScreen: (context) => HomeScreen(),
            Routes.editProfileScreen: (context) => EditProfileScreen(),
            Routes.profileScreen: (context) => ProfileScreen(),
            Routes.splashScreen: (context) => SplashScreen(),
          },
        ),
      ),
    );
  }
}
