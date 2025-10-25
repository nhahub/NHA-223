import 'package:flutter/material.dart';

class UnderlinedText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onTap; // ✅ نحتفظ بـ onTap ونستخدمه

  const UnderlinedText({
    super.key,
    required this.text,
    required this.onTap,
    this.color = Colors.black,
    this.fontSize = 20,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          decoration: TextDecoration.underline,
          decorationColor: color,
          decorationThickness: 2,
        ),
      ),
    );
  }
}
