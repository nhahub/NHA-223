import 'package:flutter/material.dart';

class AddMinusButton extends StatelessWidget {
  AddMinusButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.bg,
    required this.fg,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: fg),
      ),
    );
  }
}
