
import 'package:final_depi_project/features/product_detail/widget/colorselector.dart';
import 'package:final_depi_project/features/product_detail/widget/comment_card.dart';
import 'package:final_depi_project/features/product_detail/widget/detailcontaner.dart';
import 'package:final_depi_project/features/product_detail/widget/diagonal_painter.dart';
import 'package:final_depi_project/features/product_detail/widget/sizes.dart';
import 'package:final_depi_project/features/product_detail/widget/smalphoto.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String selectedSize = 'S';
  final sizes = ['S', 'M', 'L', 'XL', 'XXL'];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomPaint(
                painter: DiagonalPainter(),
                child: SizedBox(
                  width: size.width,
                  height: 550,
                  child: Stack(
                    children: [
                      ClipPath(
                        clipper: DiagonalClipper(),
                        child: Container(
                          width: size.width,
                          height: 550,
                          color: Colors.transparent,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 90,
                                left: (size.width - 280) / 2,
                                child: Image.asset(
                                  'assets/images/detail_image.png',
                                  width: 290,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Positioned(top: 78, left: 20, child: Smalphoto()),
                      const Positioned(top: 150, left: 20, child: Smalphoto()),
                      const Positioned(top: 220, left: 20, child: Smalphoto()),
                      Positioned(
                        top: 16,
                        left: 16,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 27,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 5,
                        child: IconButton(
                          icon: const Icon(
                            Icons.shopping_bag_outlined,
                            size: 27,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 45,
                        child: IconButton(
                          icon: const Icon(
                            Icons.favorite_border,
                            size: 27,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Positioned(
                        bottom: 100,
                        left: 10,
                        child: Row(
                          children: [
                            const Gap(20),
                            const Text(
                              'T-Shirt',
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 10, 10, 10),
                              ),
                            ),
                            const Gap(20),
                            Detailcontaner(text: 'view reviews'),
                            const Gap(50),
                            Icon(
                              Icons.star_rate_rounded,
                              color: Colors.amber[700],
                              size: 28,
                            ),
                            const Text(
                              '4.8',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 40,
                        left: 10,
                        child: Row(
                          children: [
                            const Gap(20),
                            const Text(
                              '\$ 70.00',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 10, 10, 10),
                              ),
                            ),
                            const Gap(20),
                            const Text(
                              '\$ 100.00',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 136, 134, 134),
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const Gap(20),
                            Detailcontaner(text: '30%'),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 10,
                        child: Row(
                          children: [
                            const Gap(20),
                            const Text(
                              'Size :',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 10, 10, 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(10),
              Wrap(
                spacing: 10,
                children: sizes.map((sizeText) {
                  return Sizes(
                    text: sizeText,
                    isSelected: selectedSize == sizeText,
                    onTap: () {
                      setState(() {
                        selectedSize = sizeText;
                      });
                    },
                  );
                }).toList(),
              ),
              const Gap(20),
              const ColorRow(),
              const Gap(5),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Description : ',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
                  ),
                ),
              ),
              const Gap(5),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'This is a high-quality T-shirt made from 100% cotton. It is comfortable to wear and perfect for casual outings. The fabric is soft and breathable, making it ideal for all-day wear.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                    height: 1.5,
                  ),
                ),
              ),
              const Gap(20),

              Row(
                children: [
                  const Gap(30),
                  Text(
                    "Reviews ",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
                  ),
                  Spacer(),
                  Text(
                    'See All',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const Gap(30),
                ],
              ),

              const Gap(20),
              CommentCard(
                userName: 'Karas Medhat',
                userImage: 'assets/images/detail_image.png',
                rating: 4,
                comment:
                'Great quality and fits perfectly!   Highly recommend.Great quality and fits perfectly!   Highly recommend. ',
              ),
              CommentCard(
                userName: 'Karas Medhat',
                userImage: 'assets/images/detail_image.png',
                rating: 4,
                comment:
                'Great quality and fits perfectly!   Highly recommend.Great quality and fits perfectly!   Highly recommend. ',
              ),
              CommentCard(
                userName: 'Karas Medhat',
                userImage: 'assets/images/detail_image.png',
                rating: 4,
                comment:
                'Great quality and fits perfectly!   Highly recommend.Great quality and fits perfectly!   Highly recommend. ',
              ),

        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            padding: const EdgeInsets.symmetric(vertical: 7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            side: const BorderSide(
              color: Colors.black,
              width: 1.2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75
            ),
            child: const Text(
              "Add Comment ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ),
              const Gap(20),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),

          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  side: const BorderSide(
                    color: Colors.black,
                    width: 1.2,
                  ),
                ),
                child: const Text(
                  "Buy Now",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 35),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  side: const BorderSide(
                    color: Colors.black,
                    width: 1.2,
                  ),
                ),
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
