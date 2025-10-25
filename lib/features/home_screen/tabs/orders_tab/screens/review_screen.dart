import 'package:final_depi_project/features/home_screen/tabs/orders_tab/widgets/rating_widget.dart';
import 'package:final_depi_project/features/home_screen/tabs/orders_tab/widgets/review_card_widget.dart';
import 'package:final_depi_project/helpers/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double reviewaveragerRate = 5;
  List<int> reviewcountList = [1500, 900, 600, 300, 576];
  var reviewtotalReviews = 3876;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //!-------------------------------------------------------------"app bar"
      appBar: AppBar(
        title: Center(
          child: Text(
            "Review",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              Routes.homeTab,
            ); // replace the home with product details screen
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined)),
        ],
      ),
      //!----------------------------------------------------------------"body"
      body: Center(
        child: Column(
          children: [
            //!-----------------------------------------------"review widget"
            SizedBox(
              width: 343.w,
              height: 185,
              child: RatingWidget(
                averagerRate: 5,
                countList: reviewcountList,
                totalReviews: reviewtotalReviews,
              ),
            ),

            //!---------------------------------------"rating filter buttons"
            SizedBox(height: 36.h),
            SizedBox(
              width: 343.w,
              height: 32.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //!------------all
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 50.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, size: 12.sp, color: Colors.white),
                          Text(
                            "All",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //!------------5
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 50.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            size: 12.sp,
                            color: Color(0xFFF1C644),
                          ),
                          Text("5", style: TextStyle(fontSize: 12.sp)),
                        ],
                      ),
                    ),
                  ),
                  //!------------4
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 50.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            size: 12.sp,
                            color: Color(0xFFF1C644),
                          ),
                          Text("4", style: TextStyle(fontSize: 12.sp)),
                        ],
                      ),
                    ),
                  ),
                  //!------------3
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 50.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            size: 12.sp,
                            color: Color(0xFFF1C644),
                          ),
                          Text("3", style: TextStyle(fontSize: 12.sp)),
                        ],
                      ),
                    ),
                  ),
                  //!------------2
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 50.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            size: 12.sp,
                            color: Color(0xFFF1C644),
                          ),
                          Text("2", style: TextStyle(fontSize: 12.sp)),
                        ],
                      ),
                    ),
                  ),
                  //!------------1
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 50.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            size: 12.sp,
                            color: Color(0xFFF1C644),
                          ),
                          Text("1", style: TextStyle(fontSize: 12.sp)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //!-----------------------------------------------"comment title"
            SizedBox(height: 32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "  Comment",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            //!--------------------------"list view of review comment widget"
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0.h),
                    child: SizedBox(
                      width: 343.w,
                      height: 109.h,
                      child: ReviewCard(
                        name: 'Salma Ahmed',
                        date: 'Jun 2, 2025',
                        review: 'التوصيل سريع وايضا خدمة ممتازه',
                        rating: 5,
                        photoUrl: "",
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
