import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  /// Initialize Dio with base options
  static void init({required String baseUrl}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }

  /// GET request
  static Future<Response> get(
    String url, {
    Map<String, dynamic>? query,
    String? token,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
      options: token != null
          ? Options(
              headers: {'token': token},
            ) // Changed from 'Authorization': 'Bearer $token'
          : null,
    );
  }

  /// POST request
  static Future<Response> post(
    String url, {
    required Map<String, dynamic> data,
    String? token,
  }) async {
    return await dio.post(
      url,
      data: data,
      options: token != null
          ? Options(
              headers: {'token': token},
            ) // Changed from 'Authorization': 'Bearer $token'
          : null,
    );
  }

  /// PUT request
  static Future<Response> put(
    String url, {
    required Map<String, dynamic> data,
    String? token,
  }) async {
    return await dio.put(
      url,
      data: data,
      options: token != null
          ? Options(
              headers: {'token': token},
            ) // Changed from 'Authorization': 'Bearer $token'
          : null,
    );
  }

  /// DELETE request
  static Future<Response> delete(
    String url, {
    Map<String, dynamic>? query,
    String? token,
  }) async {
    return await dio.delete(
      url,
      queryParameters: query,
      options: token != null
          ? Options(
              headers: {'token': token},
            ) // Changed from 'Authorization': 'Bearer $token'
          : null,
    );
  }
}
