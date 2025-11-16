import 'dart:convert';
import 'package:http/http.dart' as http;
import 'paymob_constants.dart';

class PaymobService {
  // 1) Get auth token
  static Future<String> getAuthToken() async {
    try {
      final url = Uri.parse("https://accept.paymob.com/api/auth/tokens");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"api_key": PaymobConstants.apiKey}),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to get auth token: ${response.body}');
      }

      final data = jsonDecode(response.body);

      if (data["token"] == null) {
        throw Exception('Token not found in response');
      }

      return data["token"];
    } catch (e) {
      throw Exception('Error getting auth token: $e');
    }
  }

  // 2) Create order
  static Future<int> createOrder(String token, int amountInCents) async {
    try {
      final url = Uri.parse("https://accept.paymob.com/api/ecommerce/orders");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "auth_token": token,
          "delivery_needed": "false",
          "amount_cents": amountInCents.toString(),
          "currency": "EGP",
          "items": [],
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to create order: ${response.body}');
      }

      final data = jsonDecode(response.body);

      if (data["id"] == null) {
        throw Exception('Order ID not found in response');
      }

      return data["id"];
    } catch (e) {
      throw Exception('Error creating order: $e');
    }
  }

  // 3) Get payment key
  static Future<String> getPaymentKey(
      String token,
      int orderId,
      int amountInCents, {
        Map<String, String>? billingData,
      }) async {
    try {
      final url = Uri.parse("https://accept.paymob.com/api/acceptance/payment_keys");

      final defaultBillingData = {
        "first_name": "First Name",
        "last_name": "Last Name",
        "email": "example@gmail.com",
        "phone_number": "01xxxxxxxxx",
        "apartment": "NA",
        "floor": "NA",
        "street": "NA",
        "building": "NA",
        "city": "Cairo",
        "country": "Egypt",
        "state": "NA"
      };

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "auth_token": token,
          "amount_cents": amountInCents.toString(),
          "expiration": 3600,
          "order_id": orderId,
          "billing_data": billingData ?? defaultBillingData,
          "integration_id": PaymobConstants.integrationIdCard,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to get payment key: ${response.body}');
      }

      final data = jsonDecode(response.body);

      if (data["token"] == null) {
        throw Exception('Payment key not found in response');
      }

      return data["token"];
    } catch (e) {
      throw Exception('Error getting payment key: $e');
    }
  }
}
