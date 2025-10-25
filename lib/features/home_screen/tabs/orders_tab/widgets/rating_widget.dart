import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final List<int>
  countList; // length 5: [count5, count4, count3, count2, count1]
  final double averagerRate;
  final int totalReviews;

  const RatingWidget({
    super.key,
    required this.countList,
    required this.averagerRate,
    required this.totalReviews,
  });

  @override
  Widget build(BuildContext context) {
    final maxCount = countList.reduce((a, b) => a > b ? a : b).toDouble();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        children: [
          // left: big score & stars & review count
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  averagerRate.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // draw 5 stars filled by averagerRate
                    for (int i = 1; i <= 5; i++)
                      Icon(
                        i <= averagerRate.round()
                            ? Icons.star
                            : Icons.star_border,
                        color: const Color(0xFFFFC107), // gold
                        size: 20,
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '$totalReviews review${totalReviews == 1 ? "" : "s"}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),

          // right: bars 5->1
          Expanded(
            flex: 6,
            child: Column(
              children: List.generate(5, (index) {
                final star = 5 - index; // 5,4,3,2,1
                final count = countList[index].toDouble();
                final fraction = maxCount == 0 ? 0.0 : (count / maxCount);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 18,
                        child: Text(
                          star.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // progress background
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: fraction.clamp(0.0, 1.0),
                              child: Container(
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 36,
                        child: Text(
                          countList[index].toString(),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
