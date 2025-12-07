import 'package:final_depi_project/core/api_constant.dart';

import '../../../../core/dio_helper.dart';
import '../model/login_response.dart';
import 'package:dio/dio.dart';

import '../model/signup_response.dart';

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

  Future<SignupResponse> signup({
    required String name,
    required String email,
    required String password,
    required String rePassword,
  }) async{

    try {
      final response =await DioHelper.post(
          ApiConstant.signupEndPoint, data: {
        "name": name,
        "email": email,
        "password": password,
        "rePassword": rePassword,
        "phone": "01211681903"
      });
      return SignupResponse.fromJson(response.data);
    }on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Signup failed');
    }
  }
}
