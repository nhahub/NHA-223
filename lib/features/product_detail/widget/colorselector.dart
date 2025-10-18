import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ColorRow extends StatefulWidget {
  const ColorRow({super.key});

  @override
  State<ColorRow> createState() => _ColorRowState();
}

class _ColorRowState extends State<ColorRow> {
  final List<Color> colors = [
    Colors.red,
    const Color.fromARGB(255, 95, 95, 95),
    const Color.fromARGB(255, 12, 211, 25),
    Colors.orange,
    const Color.fromARGB(255, 0, 0, 0),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Gap(30),
        Text(
          'Colors :',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.grey[900],
          ),
        ),
        const Gap(20),
        Expanded(
          child: SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: colors.length,
              itemBuilder: (context, index) {
                final color = colors[index];
                final isSelected = index == selectedIndex;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,

                    ),
                    child: isSelected
                        ? Center(
                      child: Container(
                        width: 13,
                        height: 13,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                        : null,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
