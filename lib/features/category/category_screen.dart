import 'package:flutter/material.dart';
import 'dart:math' as math  show math ;

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> categories = ["All", "Mens", "T-Shirt", "Pants", "Kids"];

  final List<Map<String, dynamic>> products = [
    {
      "image": "assets/images/2.png",
      "title": "T-shirt",
      "price": 50.00,
      "rating": 4.4,
    },
    {
      "image": "assets/images/3.png",
      "title": "T-shirt",
      "price": 50.00,
      "rating": 4.4,
    },
    {
      "image": "assets/images/4.png",
      "title": "T-shirt",
      "price": 50.00,
      "rating": 4.4,
    },
    {
      "image": "assets/images/5.png",
      "title": "T-shirt",
      "price": 50.00,
      "rating": 4.4,
    },
    {
      "image": "assets/images/3.png",
      "title": "Kids Wear",
      "price": 40.00,
      "rating": 4.4,
    },
    {
      "image": "assets/images/4.png",
      "title": "Dress",
      "price": 60.00,
      "rating": 4.4,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.black, size: 22),
                      onPressed: () => Navigator.pop(context),
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.search, color: Colors.black, size: 22),
                      onPressed: () {},
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 4),
                  child: Text(
                    "Mens",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                TabBar(
                  isScrollable: true,
                  controller: _tabController,
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  labelStyle:
                      const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  tabs: categories.map((cat) => Tab(text: cat)).toList(),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.75,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final item = products[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipPath(
                          clipper: DiagonalClipper(),
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.vertical(top: Radius.circular(16)),
                            ),
                            child: Stack(
                              clipBehavior: Clip.antiAlias,
                              children: [
                                CustomPaint(
                                  painter: DiagonalPainter(),
                                  child: Container(color: Colors.transparent),
                                ),
                                Center(
                                  child: Image.asset(
                                    item["image"],
                                    fit: BoxFit.contain,
                                    height: 180,
                                    alignment: Alignment.bottomCenter,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: IconButton(
                                    icon: const Icon(Icons.favorite_border),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            item["title"],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.star,
                                color: Colors.orange, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              item["rating"].toString(),
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "\$${item["price"].toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF707475)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.65);
    path.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.75,
      size.width * 0.3,
      size.height * 0.85,
    );
    path.quadraticBezierTo(
      0,
      size.height * 0.9,
      0,
      size.height * 0.65,
    );
    path.close();

    canvas.drawPath(path, paint);

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.03)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawPath(path, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.65);
    path.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.75,
      size.width * 0.3,
      size.height * 0.85,
    );
    path.quadraticBezierTo(
      0,
      size.height * 0.9,
      0,
      size.height * 0.65,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}