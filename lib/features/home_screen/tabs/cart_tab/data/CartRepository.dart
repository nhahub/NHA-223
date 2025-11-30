import 'package:dio/dio.dart';

import 'models/cartmodel.dart';

class CartRepository {
  final Dio _dio;

  CartRepository(this._dio);

  Future<CartModel> getCart() async {
    try {
      final response = await _dio.get('/cart');
      return CartModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('Cart not found');
      }
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized: Please login again');
      }
      throw Exception('Failed to load cart: ${e.response?.data?['message'] ?? e.message}');
    } catch (e) {
      throw Exception('Failed to load cart: $e');
    }
  }

  Future<CartModel> updateQuantity(String productId, int count) async {
    try {
      final response = await _dio.put('/cart/$productId', data: {
        'count': count,
      });
      return CartModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to update quantity: ${e.response?.data?['message'] ?? e.message}');
    } catch (e) {
      throw Exception('Failed to update quantity: $e');
    }
  }

  Future<CartModel> removeItem(String productId) async {
    try {
      final response = await _dio.delete('/cart/$productId');
      return CartModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to remove item: ${e.response?.data?['message'] ?? e.message}');
    } catch (e) {
      throw Exception('Failed to remove item: $e');
    }
  }

  Future<CartModel> addToCart(String productId) async {
    try {
      final response = await _dio.post('/cart', data: {
        'productId': productId,
      });
      return CartModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to add to cart: ${e.response?.data?['message'] ?? e.message}');
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  Future<void> clearCart() async {
    try {
      await _dio.delete('/cart');
    } on DioException catch (e) {
      throw Exception('Failed to clear cart: ${e.response?.data?['message'] ?? e.message}');
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }
}