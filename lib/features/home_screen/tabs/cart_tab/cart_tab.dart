import 'package:final_depi_project/features/home_screen/tabs/cart_tab/widgets/cart_item_card.dart';
import 'package:final_depi_project/features/home_screen/tabs/cart_tab/widgets/summary_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'data/models/cart_item.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final items = <CartItem>[
    CartItem(
      title: 'T-shirt',
      price: 50,
      color: 'Red',
      size: 'XXL',
      image:
      'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=600',
      qty: 1,
    ),
    CartItem(
      title: 'Jacket',
      price: 70,
      color: 'Brown',
      size: 'XXL',
      image:
      'https://images.unsplash.com/photo-1519741497674-611481863552?w=600',
      qty: 3,
    ),
    CartItem(
      title: 'Skirt',
      price: 70,
      color: 'Pink',
      size: 'XXL',
      image:
      'https://images.unsplash.com/photo-1520975661595-6453be3f7070?w=600',
      qty: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double subtotal = items.fold(0, (p, e) => p + e.price * e.qty);
    double shipping = 0;
    final double total = subtotal + shipping;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'cart',
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Poppins",
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.search_rounded),
          SizedBox(width: 15.w),
        ],
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 14.h),
                    child: CartItemCard(
                      item: item,
                      onIncrease: () => setState(() => item.qty++),
                      onDecrease: () =>
                          setState(() {
                            if (item.qty > 1) item.qty--;
                          }),
                      onDelete: () => setState(() => items.removeAt(index)),
                      onEdit: () {},
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 10.h),
            Text('Payment Summery'),
            SizedBox(height: 10.h),
            SummaryRow(
                label: 'Subtotal', value: '\$${subtotal.toStringAsFixed(2)}'),
            SizedBox(height: 6.h),
            SummaryRow(label: 'Shipping',
                value: shipping == 0 ? 'Free' : '\$$shipping'),
            Divider(height: 24.h),
            SummaryRow(label: 'Total',
                value: '\$${total.toStringAsFixed(2)}',
                bold: true),
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.black, width: 1.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                      //   Todo: navigate to payment
                      },
                      child: Text(
                        'Check out',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


