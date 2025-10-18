import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CommentCard extends StatelessWidget {
  final String userName;
  final String userImage;
  final double rating;
  final String comment;

  const CommentCard({
    super.key,
    required this.userName,
    required this.userImage,
    required this.rating,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[200],
                  child: ClipOval(
                    child: Image.asset(
                      userImage,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        if (index < rating.floor()) {
                          return Icon(Icons.star,
                              color: Colors.amber[700], size: 16);
                        } else if (index < rating) {
                          return Icon(Icons.star_half,
                              color: Colors.amber[700], size: 16);
                        } else {
                          return Icon(Icons.star_border,
                              color: Colors.amber[700], size: 16);
                        }
                      }),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(12),
            Text(
              comment,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
