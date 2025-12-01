import 'package:final_depi_project/features/home_screen/tabs/cart_tab/widgets/AnimatedDoalog.dart';
import 'package:final_depi_project/features/home_screen/tabs/cart_tab/widgets/showDeleteConfirmation.dart';
import 'package:final_depi_project/features/home_screen/tabs/cart_tab/widgets/cart_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';
import 'cubit/cart_cubit.dart';
import 'data/models/cartmodel.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartCubit>().loadCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const CartTabView();
  }
}

class CartTabView extends StatelessWidget {
  const CartTabView({super.key});

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String itemId, String itemName) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AnimatedDialog(
        itemName: itemName,
        onCancel: () => Navigator.of(dialogContext).pop(false),
        onConfirm: () => Navigator.of(dialogContext).pop(true),
      ),
    );

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

  Future<void> _handleCheckout(BuildContext context, double total) async {
    await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => PaymentView(
          onPaymentSuccess: () {
            context.read<CartCubit>().clearCart();
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
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
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
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartError) {
            _showErrorSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is CartInitial) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                context.read<CartCubit>().loadCart();
              }
            });

            return Center(
              child: CircularProgressIndicator(
                color: Color(0xFF070707),
                strokeWidth: 4.0,
              ),
            );
          }

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

  Widget _buildCartContent(BuildContext context, CartModel cart) {
    final double shipping = 0;
    final double total = (cart.totalCartPrice ?? 0).toDouble() + shipping;

    final bottomNavigationBarHeight = 5.h;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

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
              itemCount: cart.items?.length ?? 0,
              itemBuilder: (context, index) {
                final item = cart.items![index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 14.h),
                  child: CartItemCard(
                    item: item,
                    onIncrease: () {
                      context.read<CartCubit>().increaseQuantity(
                        item.productId ?? '',
                        item.count,
                      );
                    },
                    onDecrease: () {
                      context.read<CartCubit>().decreaseQuantity(
                        item.productId ?? '',
                        item.count,
                      );
                    },
                    onDelete: () {
                      _showDeleteConfirmation(
                        context,
                        item.productId ?? '',
                        'Product ${item.productId}',
                      );
                    },
                    onEdit: () {},
                  ),
                );
              },
            ),
          ),

          // Payment Summary Section
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 16.h,
              bottom: bottomPadding + bottomNavigationBarHeight + 16.h,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'Payment Summary',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                SummaryRow(
                  label: 'Subtotal',
                  value: '\$${(cart.totalCartPrice ?? 0).toStringAsFixed(2)}',
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
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.3),
                        Colors.grey.withOpacity(0.3),
                        Colors.white.withOpacity(0.1),
                      ],
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _handleCheckout(context, total),
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.80),
                              Colors.black.withOpacity(0.60),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Check out',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
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