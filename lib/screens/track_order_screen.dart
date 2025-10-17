import 'package:final_depi_project/widgets/navigation_bar_widget.dart';
import 'package:final_depi_project/widgets/order_item_widget.dart';
import 'package:flutter/material.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Track Order",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios, size: 24),
        ),
      ),
      body: Center(
        child: Container(
          width: 343,
          height: 812,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        width: 343,
                        height: 150,
                        child: OrderItemWidget(
                          title: 'T-shirt',
                          description:
                              'Lorem ipsum dolor sit amet consectetur.',
                          time: '15 min',
                          photoUrl: '',
                          orderId: "",
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
