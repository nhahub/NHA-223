import 'package:flutter/material.dart';

class DiagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF707475)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);

    path.lineTo(size.width, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.98, size.height * 0.75,
      size.width * 0.9, size.height * 0.73,
    );
    path.lineTo(size.width * 0.1, size.height * 0.6);
    path.quadraticBezierTo(
      size.width * 0.0, size.height * 0.58,
      0, size.height * 0.545,
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
    path.lineTo(size.width, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.98, size.height * 0.75,
      size.width * 0.9, size.height * 0.73,
    );
    path.lineTo(size.width * 0.1, size.height * 0.6);
    path.quadraticBezierTo(
      0, size.height * 0.58,
      0, size.height * 0.545,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}