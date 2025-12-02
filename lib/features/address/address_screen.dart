import 'package:final_depi_project/features/address/screens/select_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

import '../../helpers/routes.dart';
import '../home_screen/tabs/cart_tab/cubit/cart_cubit.dart';

class AddressScreen extends StatefulWidget {
  AddressScreen({super.key,required this.total});
  double total;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final countryController = TextEditingController();
  final fullNameController = TextEditingController();
  final cityController = TextEditingController();
  final postalController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Add Your Address",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                  controller: countryController,
                  label: "Country",
                  hint: "Egypt"),

              const SizedBox(height: 16),

              _buildTextField(
                  controller: fullNameController,
                  label: "Full Name",
                  hint: "Kareem Ebrahim"),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                        controller: cityController,
                        label: "City",
                        hint: "Cairo"),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                        controller: postalController,
                        label: "Postal Code",
                        hint: "3125",
                        keyboardType: TextInputType.number),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _buildTextField(
                  controller: addressController,
                  label: "Delivery address",
                  hint: "25street Ahmed Orabi"),

              const SizedBox(height: 16),

              _buildTextField(
                controller: phoneController,
                label: "Phone Number",
                hint: "+201158664410",
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 16),

              _buildTextField(
                controller: emailController,
                label: "Email",
                hint: "example@mail.com",
                keyboardType: TextInputType.emailAddress,
                isEmail: true,
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                             PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => PaymentView(
                                onPaymentSuccess: () {
                                  context.read<CartCubit>().clearCart();
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.homeScreen,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("payment success"),
                                      backgroundColor: Colors.green,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );


                                },
                                onPaymentError: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.homeScreen,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Error while payment please try again"),
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );


                                },
                                price: widget.total,
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
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Continue To payment",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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

  // Reusable TextField with validation
  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool isEmail = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "$label is required";
            }

            if (isEmail) {
              final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(value)) {
                return "Enter a valid email";
              }
            }

            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
