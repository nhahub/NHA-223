import 'package:flutter/material.dart';

class Detailcontaner extends StatelessWidget {
  final String text;

  Detailcontaner({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: const BoxDecoration(
        color: Color.fromARGB(59, 229, 56, 53),
        borderRadius: BorderRadius.all(Radius.circular(13)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(255, 255, 0, 0),
        ),
      ),
    );
  }
}
