import 'package:dio/dio.dart';
import '../../../../../core/dio_helper.dart';
import '../../../../../core/api_constant.dart';
import '../data/models/cart.dart';
import 'dart:developer' as developer;

class CartService {
  static Future<Cart> getLoggedUserCart(String token) async {
    try {
      developer.log('🛒 Fetching user cart...', name: 'CartService');

      final response = await DioHelper.get(
        ApiConstant.cartEndPoint,
        token: token,
      );

      developer.log(' Cart fetched successfully', name: 'CartService');

      if (response.data == null ||
          response.data['data'] == null ||
          response.data['data']['products'] == null ||
          (response.data['data']['products'] as List).isEmpty) {
        developer.log('📭 Cart is empty', name: 'CartService');
        return Cart.empty();
      }

      return Cart.fromJson(response.data);

    } on DioException catch (e) {
      developer.log(' DioException: ${e.message}', name: 'CartService', error: e);

      if (e.response?.statusCode == 401) {
        throw Exception('Token expired. Please login again.');
      } else if (e.response?.statusCode == 404) {
        developer.log(' Cart not found, returning empty cart', name: 'CartService');
        return Cart.empty();
      } else if (e.response?.statusCode == 500) {
        throw Exception('Server error. Please try again later.');
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('No internet connection. Please check your network.');
      }

      // Check if response contains token expired message
      if (e.response?.data != null) {
        final responseData = e.response!.data;
        if (responseData is Map &&
            (responseData['message']?.toString().toLowerCase().contains('expired') == true ||
                responseData['message']?.toString().toLowerCase().contains('token') == true)) {
          throw Exception('Token expired. Please login again.');
        }
      }

      throw Exception('Failed to fetch cart: ${e.message}');

    } catch (e) {
      developer.log(' Unexpected error: $e', name: 'CartService', error: e);
      throw Exception('Unexpected error occurred: $e');
    }
  }

  static Future<Cart> updateCartItemQuantity({
    required String token,
    required String cartItemId,
    required int quantity,
  }) async {
    try {
      developer.log(' Updating cart item quantity...', name: 'CartService');

      final response = await DioHelper.put(
        '${ApiConstant.cartEndPoint}/$cartItemId',
        data: {'count': quantity},
        token: token,
      );

      developer.log(' Cart item updated', name: 'CartService');
      return Cart.fromJson(response.data);

    } on DioException catch (e) {
      developer.log(' Failed to update cart: ${e.message}', name: 'CartService');

      if (e.response?.statusCode == 401) {
        throw Exception('Token expired. Please login again.');
      }

      if (e.response?.data != null) {
        final responseData = e.response!.data;
        if (responseData is Map &&
            (responseData['message']?.toString().toLowerCase().contains('expired') == true ||
                responseData['message']?.toString().toLowerCase().contains('token') == true)) {
          throw Exception('Token expired. Please login again.');
        }
      }

      throw Exception('Failed to update cart item');
    }
  }

  static Future<Cart> removeFromCart({
    required String token,
    required String cartItemId,
  }) async {
    try {
      developer.log(' Removing item from cart...', name: 'CartService');

      final response = await DioHelper.delete(
        '${ApiConstant.cartEndPoint}/$cartItemId',
        token: token,
      );

      developer.log(' Item removed from cart', name: 'CartService');
      return Cart.fromJson(response.data);

    } on DioException catch (e) {
      developer.log(' Failed to remove from cart: ${e.message}', name: 'CartService');

      if (e.response?.statusCode == 401) {
        throw Exception('Token expired. Please login again.');
      }

      if (e.response?.data != null) {
        final responseData = e.response!.data;
        if (responseData is Map &&
            (responseData['message']?.toString().toLowerCase().contains('expired') == true ||
                responseData['message']?.toString().toLowerCase().contains('token') == true)) {
          throw Exception('Token expired. Please login again.');
        }
      }

      throw Exception('Failed to remove item from cart');
    }
  }
}