import 'package:dio/dio.dart';
import 'package:final_depi_project/core/shared_prefrences.dart';

class DioHelper {
  static late Dio dio;

  /// Initialize Dio with base options
  static void init({required String baseUrl}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {'Content-Type': 'application/json'},
        receiveDataWhenStatusError: true,
      ),
    );

    // Add interceptor for automatic token handling
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Get token from shared preferences
        final token = await AppSharedPreferences.getString(SharedPreferencesKeys.token);
        if (token != null && token.isNotEmpty) {
          options.headers['token'] = token;
          print('🔑 Token added to request: $token');
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        // Handle token expiration or other errors
        if (error.response?.statusCode == 401) {
          print('🚫 Token expired or invalid');
          // You can add token refresh logic here
        }
        return handler.next(error);
      },
    ));
  }

  /// GET request
  static Future<Response> get(
      String url, {
        Map<String, dynamic>? query,
        String? token,
        bool useInterceptorToken = true, // اختيار استخدام الـ interceptor أو الـ token الممرر
      }) async {
    return await dio.get(
      url,
      queryParameters: query,
      options: (token != null && !useInterceptorToken)
          ? Options(headers: {'token': token})
          : null,
    );
  }

  /// POST request
  static Future<Response> post(
      String url, {
        required Map<String, dynamic> data,
        String? token,
        bool useInterceptorToken = true,
      }) async {
    return await dio.post(
      url,
      data: data,
      options: (token != null && !useInterceptorToken)
          ? Options(headers: {'token': token})
          : null,
    );
  }

  /// PUT request
  static Future<Response> put(
      String url, {
        required Map<String, dynamic> data,
        String? token,
        bool useInterceptorToken = true,
      }) async {
    return await dio.put(
      url,
      data: data,
      options: (token != null && !useInterceptorToken)
          ? Options(headers: {'token': token})
          : null,
    );
  }

  /// DELETE request
  static Future<Response> delete(
      String url, {
        Map<String, dynamic>? query,
        String? token,
        bool useInterceptorToken = true,
      }) async {
    return await dio.delete(
      url,
      queryParameters: query,
      options: (token != null && !useInterceptorToken)
          ? Options(headers: {'token': token})
          : null,
    );
  }

  /// PATCH request (إضافة إذا كنت تحتاجها)
  static Future<Response> patch(
      String url, {
        required Map<String, dynamic> data,
        String? token,
        bool useInterceptorToken = true,
      }) async {
    return await dio.patch(
      url,
      data: data,
      options: (token != null && !useInterceptorToken)
          ? Options(headers: {'token': token})
          : null,
    );
  }

  /// Clear all interceptors (إذا أردت إعادة التعيين)
  static void clearInterceptors() {
    dio.interceptors.clear();
  }

  /// Add custom interceptor
  static void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }
}