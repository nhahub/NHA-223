// ignore_for_file: sized_box_for_whitespace, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),

          SizedBox(height: 10.h),

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Arrival : ',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: arrivalText,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 14.h),

          //! Stepper area: line + circles + labels
          SizedBox(
            width: 343.w,
            height: 45.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // base thin grey line
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 2.h,
                    width: double.infinity.w, // fills the 343 parent
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
                        width: 12.w,
                        height: 12.h,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      );
                    } else if (isDone) {
                      circle = Container(
                        width: 10.w,
                        height: 10.h,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check,
                            size: 8.sp,
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      circle = Container(
                        width: 10.w,
                        height: 10.h,
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
                          SizedBox(height: 4.sp),

                          Center(
                            child: Text(
                              _labels[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10.sp,
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

          SizedBox(height: 36.h),

          Text(
            updatedText.isEmpty ? 'Updated: just now' : updatedText,
            style: TextStyle(
              fontSize: 8.sp,
              color: Colors.grey[500],
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
