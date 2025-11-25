import 'package:final_depi_project/core/api_constant.dart';

import '../../../../core/dio_helper.dart';
import '../model/login_response.dart';
import 'package:dio/dio.dart';

class AuthRepository {

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioHelper.post(
        ApiConstant.loginEndPoint,
        data: {
          'email': email,
          'password': password,
        },
      );
      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Login failed');
      } else {
        throw Exception(e.message);
      }
    }
  }
}
