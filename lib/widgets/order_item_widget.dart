// ignore_for_file: sized_box_for_whitespace, sort_child_properties_last

import 'package:final_depi_project/helpers/routes.dart';
import 'package:flutter/material.dart';

class OrderItemWidget extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final String? photoUrl; // optional photo URL
  final String? orderId;
  const OrderItemWidget({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    this.photoUrl,
    this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 150,
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(width: 0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //! Image
          SizedBox(width: 16),
          Container(
            width: 118,
            height: 118,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: (photoUrl == null || photoUrl!.isEmpty)
                  ? Image.asset(
                      'assets/Google.png',
                      width: 118,
                      height: 118,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      photoUrl!,
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/Goggle.png',
                          width: 118,
                          height: 118,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
            ),
          ),

          SizedBox(width: 8),

          //! Column (title, description, time)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 6),
              SizedBox(
                width: 137,
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9E9E9E),
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                time,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(width: 8),
          //! Arrow button
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context,Routes.trackorder2);
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),

          SizedBox(width: 15.5),
        ],
      ),
    );
  }
}
