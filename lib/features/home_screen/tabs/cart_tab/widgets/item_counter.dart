import 'package:final_depi_project/features/home_screen/tabs/cart_tab/widgets/add_minus_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCounter extends StatelessWidget {
  const ItemCounter({super.key, required  this.qty,
    required  this.onMinus,
    required  this.onPlus,});
  final int qty;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFEFEFEF)),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Color(0x14000000), blurRadius: 6)],
      ),
      child: Row(
        children: [

          AddMinusButton(
            icon: Icons.remove_rounded,
            onTap: onMinus,
            bg: Color(0xFFFFF1E5),
            fg: Color(0xFF0B0B0B),
          ),
          SizedBox(width: 8.w),
          Text('$qty', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(width: 8.w),
          AddMinusButton(
            icon: Icons.add_rounded,
            onTap: onPlus,
            bg: Color(0xFFFFF1E5),
            fg: Color(0xFF0A0A0A),
          ),
        ],
      ),
    );
  }

}
