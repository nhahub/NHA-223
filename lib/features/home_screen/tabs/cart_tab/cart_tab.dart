import 'package:final_depi_project/features/home_screen/tabs/cart_tab/widgets/showDeleteConfirmation.dart';
import 'package:final_depi_project/features/home_screen/tabs/cart_tab/widgets/cart_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';
import 'cubit/cart_cubit.dart';
import 'widgets/cart_item_card.dart';
import 'widgets/summary_row.dart';
import 'widgets/EmptyCart.dart';
import 'cubit/cart_state.dart';
import '../../../../helpers/routes.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => CartCubit()..loadCart(),
      child: const CartTabView(),
    );
  }
}

class CartTabView extends StatelessWidget {
  const CartTabView({super.key});

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }
// في ملف cart_tab.dart
// استبدل دالة _showDeleteConfirmation بهذه الدالة:

  void _showDeleteConfirmation(BuildContext context, String itemId, String itemName) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.red,
                  size: 48.sp,
                ),
              ),

              SizedBox(height: 20.h),

              // Title
              Text(
                'Remove Item?',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 12.h),

              // Message
              Text(
                'Are you sure you want to remove\n"$itemName" from your cart?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),

              SizedBox(height: 24.h),

              // Buttons
              Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(dialogContext).pop(false),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        side: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 12.w),

                  // Delete Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(dialogContext).pop(true),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Remove',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    // لو المستخدم ضغط Remove
    if (result == true && context.mounted) {
      try {
        await context.read<CartCubit>().removeItem(itemId);
        if (context.mounted) {
          _showSuccessSnackBar(context, 'Item removed from cart');
        }
      } catch (e) {
        if (context.mounted) {
          _showErrorSnackBar(context, 'Failed to remove item');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Cart',
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
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartError) {
            _showErrorSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xFF070707),
                strokeWidth: 4.0,
              ),
            );
          }

          if (state is CartEmpty) {
            return buildEmptyCart(context);
          }

          if (state is CartLoaded) {
            return _buildCartContent(context, state.cart);
          }

          if (state is CartUpdating) {
            return Stack(
              children: [
                _buildCartContent(context, state.cart),
                Container(
                  color: Colors.black.withOpacity(0.1),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF070707),
                    ),
                  ),
                ),
              ],
            );
          }

          return Center(
            child: CircularProgressIndicator(color: Color(0xFF070707)),
          );
        },
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, cart) {
    final double shipping = 0;
    final double total = cart.totalCartPrice + shipping;

    return RefreshIndicator(
      onRefresh: () async {
        await context.read<CartCubit>().refreshCart();
      },
      color: Color(0xFF0B0B0B),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 14.h),
                  child: CartItemCard(
                    item: item,
                    onIncrease: () {
                      context.read<CartCubit>().increaseQuantity(
                        item.id ?? '',
                        item.count,
                      );
                    },
                    onDecrease: () {
                      context.read<CartCubit>().decreaseQuantity(
                        item.id ?? '',
                        item.count,
                      );
                    },
                    onDelete: () {
                      _showDeleteConfirmation(
                          context,
                          item.id ?? '',
                          item.product?.name ?? 'Item'
                      );
                    },
                    onEdit: () {},
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Payment Summary',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 10.h),
          SummaryRow(
            label: 'Subtotal',
            value: '\$${cart.totalCartPrice.toStringAsFixed(2)}',
          ),
          SizedBox(height: 6.h),
          SummaryRow(
            label: 'Shipping',
            value: shipping == 0 ? 'Free' : '\$$shipping',
          ),
          Divider(height: 24.h),
          SummaryRow(
            label: 'Total',
            value: '\$${total.toStringAsFixed(2)}',
            bold: true,
          ),
          Container(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentView(
                            onPaymentSuccess: () {
                              Navigator.pushReplacementNamed(
                                context,
                                Routes.homeScreen,
                              );
                              _showSuccessSnackBar(
                                context,
                                'Payment successful!',
                              );
                            },
                            onPaymentError: () {
                              Navigator.pushReplacementNamed(
                                context,
                                Routes.homeScreen,
                              );
                              _showErrorSnackBar(
                                context,
                                'Error while payment please try again',
                              );
                            },
                            price: total,
                          ),
                        ),
                      );
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
    );
  }
}