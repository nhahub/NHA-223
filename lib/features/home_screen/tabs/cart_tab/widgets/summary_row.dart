import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SummaryRow extends StatelessWidget {
  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.bold = false,
  });

  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14.sp, color: Color(0xFF6C6C6C))),
          Text(
            value,
            style: TextStyle(
              fontSize: bold ? 18.sp : 14.sp,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
