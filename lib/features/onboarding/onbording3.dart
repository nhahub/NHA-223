
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OnboardPage3 extends StatelessWidget {
  const OnboardPage3({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(180),
              bottomRight: Radius.circular(180),
            ),
            child: Container(
              width: size.width,
              height: size.height * 0.59,
              color: Colors.black,
              child: Stack(
                children: [

                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Transform.translate(
                      offset: Offset(
                        -size.width * 0.0098,
                        size.height * 0.2,
                      ),
                      child: Image.asset(
                        'assets/images/onbourding3.png',
                        width: size.width * 0.9,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(30),
          const Text(
            'Smart Shopping',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Gap(10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Save your favorites, track your orders, and shop with ease. Your fashion journey starts here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(179, 8, 8, 8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}