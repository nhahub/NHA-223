import 'package:dio/dio.dart';
import 'package:final_depi_project/core/dio_helper.dart';

class AddressRepository {
  Future<Response> addAddress({
    required Map<String, dynamic> addressData,
    required String token,
  }) async {
    try {
      final response = await DioHelper.post(
        "/addresses",
        data: addressData,
        token: token,
      );
      return response;
    } on DioException catch (e) {
      print("❌ ERROR RESPONSE FROM SERVER (add): ${e.response?.data}");

      String message = 'Failed to add address';

      final data = e.response?.data;
      if (data is Map && data['message'] is String) {
        message = data['message'];
      }

      throw Exception(message);
    } catch (e) {
      print("❌ UNKNOWN ERROR (add): $e");
      throw Exception('Something went wrong while adding address');
    }
  }

  Future<Response> getAllAddresses({required String token}) async {
    try {
      final response = await DioHelper.get(
        "/addresses",
        token: token,
      );
      return response;
    } on DioException catch (e) {
      print("❌ ERROR RESPONSE FROM SERVER (getAll): ${e.response?.data}");

      String message = 'Failed to load addresses';

      final data = e.response?.data;
      if (data is Map && data['message'] is String) {
        message = data['message'];
      }

      throw Exception(message);
    } catch (e) {
      print("❌ UNKNOWN ERROR (getAll): $e");
      throw Exception('Something went wrong while loading addresses');
    }
  }

  Future<Response> getAddressById({
    required String id,
    required String token,
  }) async {
    try {
      final response = await DioHelper.get(
        "/addresses/$id",
        token: token,
      );
      return response;
    } on DioException catch (e) {
      print("❌ ERROR RESPONSE FROM SERVER (getById): ${e.response?.data}");

      String message = 'Failed to get address';

      final data = e.response?.data;
      if (data is Map && data['message'] is String) {
        message = data['message'];
      }

      throw Exception(message);
    } catch (e) {
      print("❌ UNKNOWN ERROR (getById): $e");
      throw Exception('Something went wrong while getting the address');
    }
  }

  Future<Response> removeAddress({
    required String id,
    required String token,
  }) async {
    try {
      final response = await DioHelper.delete(
        "/addresses/$id",
        token: token,
      );
      return response;
    } on DioException catch (e) {
      print("❌ ERROR RESPONSE FROM SERVER (remove): ${e.response?.data}");

      String message = 'Failed to remove address';

      final data = e.response?.data;
      if (data is Map && data['message'] is String) {
        message = data['message'];
      }

      throw Exception(message);
    } catch (e) {
      print("❌ UNKNOWN ERROR (remove): $e");
      throw Exception('Something went wrong while removing address');
    }
  }

  Future<Response> updateAddress({
    required String id,
    required Map<String, dynamic> addressData,
    required String token,
  }) async {
    try {
      final response = await DioHelper.put(
        "/addresses/$id",
        data: addressData,
        token: token,
      );
      return response;
    } on DioException catch (e) {
      print("❌ ERROR RESPONSE FROM SERVER (update): ${e.response?.data}");

      String message = 'Failed to update address';

      final data = e.response?.data;
      if (data is Map && data['message'] is String) {
        message = data['message'];
      }

      throw Exception(message);
    } catch (e) {
      print("❌ UNKNOWN ERROR (update): $e");
      throw Exception('Something went wrong while updating address');
    }
  }
}
