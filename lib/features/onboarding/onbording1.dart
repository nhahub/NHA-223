
import 'package:final_depi_project/features/home_screen/tabs/home_tab/peresentaion/home_tab.dart';
import 'package:final_depi_project/features/onboarding/widgets/Skiptext.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/shared_prefrences.dart';
import '../../helpers/routes.dart';


class OnboardPage1 extends StatelessWidget {
  const OnboardPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.58,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(180),
                      bottomRight: Radius.circular(180),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: UnderlinedText(
                    text: "Skip",
                    color: Colors.black,
                    onTap: () {
                      AppSharedPreferences.setString(SharedPreferencesKeys.isOnBoardingFinished, "isFinished");
                      Navigator.of(context).pushReplacementNamed(
                        Routes.signinScreen);
                    },
                  ),
                ),

                Positioned(
                  top: 100,
                  left: 90,
                  child: Container(
                    width: 250,
                    height: 400,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/onbourding1.png',
                        ),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(30),
            const Text(
              'Explore Styles',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Gap(10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Discover endless fashion styles tailored to your taste. From casual to classy, find the perfect look that matches your vibe.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(179, 207, 207, 207),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
