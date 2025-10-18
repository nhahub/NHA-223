// ignore_for_file: must_be_immutable

import 'package:final_depi_project/widgets/order_process_card_widget.dart';
import 'package:flutter/material.dart';

class TrackOrderScreen2 extends StatelessWidget {
  String? orderId;
  String? orderdate;
  TrackOrderScreen2({super.key, this.orderId, this.orderdate});

  @override
  Widget build(BuildContext context) {
    orderId = "04555174";
    orderdate = "Wed, 15, june 2020, 11:35 PM";
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "T-Shirt",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios, size: 24, color: Colors.white),
        ),
      ),

      body: Center(
        child: Container(
          width: double.infinity,
          height: 812,
          child: Column(
            children: [
              //!-------------------------------------------------------"stack"
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 57,
                    color: Colors.black,
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 343,
                      height: 114,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color(0xFFFAFAFA),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 18),
                          Container(
                            width: 189,
                            height: 28,

                            child: Text(
                              "Order ID :$orderId",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(height: 18),
                          Center(
                            child: Container(
                              width: 222,
                              height: 22,

                              child: Text(
                                "$orderdate",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF8E8E8E),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              //!-----------------------------------------------"order process"
              SizedBox(height: 126),
              Container(
                width: 343,
                height: 172,
                child: OrderProgressCard(
                  deliveryBy: 'Ahmed',
                  arrivalText: 'Friday 12 Dec , 2025 By 8.00 Pm',
                  currentStep: 2, // 0..4
                  updatedText: 'Updated: 10 min ago',
                ),
              ),

              //!-----------------------------------------------"order cancel"
              SizedBox(height: 228),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 343,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 1, color: Colors.red),
                  ),
                  child: const Center(
                    child: Text(
                      "Cancel Order",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
