// ignore_for_file: sized_box_for_whitespace, sort_child_properties_last

import 'package:flutter/material.dart';

class OrderProgressCard extends StatelessWidget {
  final String deliveryBy;
  final String arrivalText;
  final int currentStep;
  final String updatedText;

  const OrderProgressCard({
    super.key,
    required this.deliveryBy,
    required this.arrivalText,
    this.currentStep = 2,
    this.updatedText = '',
  });

  static const List<String> _labels = [
    'Placed',
    'Packing',
    'Dispatched',
    'In Transit',
    'Delivered',
  ];

  @override
  Widget build(BuildContext context) {
    //! clamp step
    final step = currentStep.clamp(0, _labels.length - 1);

    return Container(
      width: 343,
      height: 172,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //! Title
          Text(
            'Delivery By $deliveryBy',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 10),

          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Arrival : ',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: arrivalText,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          //! Stepper area: line + circles + labels
          SizedBox(
            width: 343,
            height: 34,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // base thin grey line
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 2,
                    width: double.infinity, // fills the 343 parent
                    color: const Color(0xFFE0E0E0),
                  ),
                ),

                //! progress (black) overlay width according to step
                Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: (_labels.length == 1)
                        ? 1.0
                        : (step / (_labels.length - 1)),
                    child: Container(height: 2, color: Colors.black),
                  ),
                ),

                //! circles and labels — each step gets equal space using Expanded
                Row(
                  children: List.generate(_labels.length, (index) {
                    final bool isDone = index < step;
                    final bool isCurrent = index == step;

                    Widget circle;
                    if (isCurrent) {
                      circle = Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      );
                    } else if (isDone) {
                      circle = Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.check,
                            size: 8,
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      circle = Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Color(0xFFBDBDBD),
                          shape: BoxShape.circle,
                        ),
                      );
                    }

                    final labelColor = isDone || isCurrent
                        ? const Color(0xFF616161)
                        : const Color(0xFFBDBDBD);

                    return Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          circle,
                          const SizedBox(height: 4),

                          Center(
                            child: Text(
                              _labels[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: labelColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

          SizedBox(height: 36),

          Text(
            updatedText.isEmpty ? 'Updated: just now' : updatedText,
            style: TextStyle(
              fontSize: 8,
              color: Colors.grey[500],
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
