import 'package:flutter/material.dart';

class Sizes extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  const Sizes({
    super.key,
    required this.text,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 70,
        height: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:  const Color.fromARGB(1, 246, 246, 246),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            color :isSelected?Colors.black: const Color.fromARGB(207, 156, 156, 156),
            width:isSelected?1.4: 1.2,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize:isSelected?27: 24,
            fontWeight: FontWeight.w500,
            color:isSelected?Colors.black: const Color.fromARGB(188, 66, 66, 66),
          ),
        ),
      ),
    );
  }
}
