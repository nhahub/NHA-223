// ignore_for_file: sized_box_for_whitespace, sort_child_properties_last

import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String name;
  final String date;
  final String review;
  final int rating;
  final String? photoUrl; // optional photo URL

  const ReviewCard({
    super.key,
    required this.name,
    required this.date,
    required this.review,
    required this.rating,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 109,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          //! row (photo + column[name + date]  + rate (star icon + rate))
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 16),
              //! photo + column[name + date]
              Container(
                width: 36,
                height: 36,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: (photoUrl == null || photoUrl!.isEmpty)
                      ? Image.asset(
                          'assets/photo2.png',
                          width: 36,
                          height: 36,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          photoUrl!,
                          width: 36,
                          height: 36,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/photo2.png',
                              width: 36,
                              height: 36,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                ),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF9C9C9C),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 174),
              //! rate (star icon + rate)
              Row(
                children: [
                  Icon(Icons.star, color: Color(0xFFFFC107), size: 12),
                  SizedBox(width: 4),
                  Text(
                    rating.toString(),
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),

          //! row (comment)
          Row(
            children: [
              SizedBox(width: 47),
              Text(
                review,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
