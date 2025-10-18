import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'offer_item.dart';

class OffersSlider extends StatefulWidget {
  const OffersSlider({super.key});

  @override
  State<OffersSlider> createState() => _OffersSliderState();
}

class _OffersSliderState extends State<OffersSlider> {
  final controller = CarouselSliderController();
  int index = 0;
  @override
  Widget build(BuildContext context) {


    final pages = [
      OfferItem(
        image:
        'https://images.pexels.com/photos/3965545/pexels-photo-3965545.jpeg?auto=compress&cs=tinysrgb&w=1200',
        title: '50% Off',
        subtitle: 'Limitted Time Only!',
      ),
      OfferItem(
        image:
        'https://images.pexels.com/photos/5632371/pexels-photo-5632371.jpeg?auto=compress&cs=tinysrgb&w=1200',
        title: 'New Arrivals',
        subtitle: 'Fresh styles for you',
      ),
      OfferItem(
        image:
        'https://images.pexels.com/photos/7679721/pexels-photo-7679721.jpeg?auto=compress&cs=tinysrgb&w=1200',
        title: 'Clearance',
        subtitle: 'Last chance deals',
      ),
    ];

    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: controller,
          itemCount: pages.length,
          itemBuilder: (_, i, __) => pages[i],
          options: CarouselOptions(
            height: 170.h,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            autoPlay: true,
            onPageChanged: (i, _) => setState(() => index = i),
          ),
        ),
        SizedBox(height: 10.h),
        Center(
          child: AnimatedSmoothIndicator(
            activeIndex: index,
            count: pages.length,
            effect: WormEffect(
              dotHeight: 10.w,
              dotWidth: 10.w,
              spacing: 8.w,
              activeDotColor: Colors.black,
              dotColor: Colors.black.withOpacity(0.3),
            ),
            onDotClicked: (i) => controller.animateToPage(i),
          ),
        ),
      ],
    );
  }
}