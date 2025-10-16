import 'package:final_depi_project/widgets/rating_widget.dart';
import 'package:final_depi_project/widgets/review_card_widget.dart';
import 'package:flutter/material.dart';

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
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined)),
        ],
      ),
      //!----------------------------------------------------------------"body"
      body: Center(
        child: Container(
          width: 375,
          height: 812,
          child: Column(
            children: [
              //!-----------------------------------------------"review widget"
              Container(
                width: 343,
                height: 185,
                child: RatingWidget(
                  averagerRate: 5,
                  countList: reviewcountList,
                  totalReviews: reviewtotalReviews,
                ),
              ),

              //!---------------------------------------"rating filter buttons"
              SizedBox(height: 36),
              Container(
                width: 343,
                height: 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //!------------all
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Colors.white),
                            Text("All", style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    //!------------5
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Color(0xFFF1C644)),
                            Text("5"),
                          ],
                        ),
                      ),
                    ),
                    //!------------4
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Color(0xFFF1C644)),
                            Text("4"),
                          ],
                        ),
                      ),
                    ),
                    //!------------3
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Color(0xFFF1C644)),
                            Text("3"),
                          ],
                        ),
                      ),
                    ),
                    //!------------2
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Color(0xFFF1C644)),
                            Text("2"),
                          ],
                        ),
                      ),
                    ),
                    //!------------1
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Color(0xFFF1C644)),
                            Text("1"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //!-----------------------------------------------"comment title"
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Comment",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),

              //!--------------------------"list view of review comment widget"
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        width: 343,
                        height: 109,
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
      ),
    );
  }
}
