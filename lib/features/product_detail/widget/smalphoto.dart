import 'package:flutter/material.dart';

class Smalphoto extends StatelessWidget {
  const Smalphoto({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color.fromARGB(255, 255, 255, 255),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: FittedBox(
            fit: BoxFit.none,
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/detail_image2.jpg',
              width: 80,
              height: 110,
            ),
          ),
        ),
      )
    ;
  }
}
