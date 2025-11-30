
import 'package:final_depi_project/features/home_screen/tabs/home_tab/peresentaion/home_tab.dart';
import 'package:final_depi_project/features/onboarding/widgets/Skiptext.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OnboardPage2 extends StatelessWidget {
  const OnboardPage2({super.key});

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
                  Positioned(
                    top: 50,
                    right: 30,
                    child: UnderlinedText(
                      text: "Skip",
                      color: Colors.white,
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomeTab()),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Transform.translate(
                      offset: const Offset(
                        -30,
                        0,
                      ),
                      child: Image.asset(
                        'assets/images/onbourding2.png',
                        width: 400,
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
            'Unique Outfits',
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
              'Find your unique fashion statement with designs that speak to your individuality and confidence.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(179, 8, 8, 8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
