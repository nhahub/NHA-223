import 'dart:developer' as developer;

import 'package:dio/dio.dart';

import '../../../core/api_constant.dart';
import '../../../core/dio_helper.dart';

Future<Map<String, dynamic>> getAllProducts({int page = 1, int limit = 10}) async {
try {
developer.log('🛍️ Fetching products page $page...', name: 'ProductsService');

final response = await DioHelper.get(
ApiConstant.productsEndPoint,
query: {
'page': page,
'limit': limit,
},
);

developer.log('✅ Products page $page fetched successfully', name: 'ProductsService');

if (response.data == null || response.data['data'] == null) {
return {
'data': [],
'hasMore': false,
};
}

final metadata = response.data['metadata'] ?? {};
final currentPage = metadata['currentPage'] ?? page;
final totalPages = metadata['numberOfPages'] ?? 1;
final nextPage = metadata['nextPage'];

return {
'data': response.data['data'],
'hasMore': nextPage != null, // أو currentPage < totalPages
'currentPage': currentPage,
'totalPages': totalPages,
};

} on DioException catch (e) {
developer.log('❌ Error fetching products: ${e.message}', name: 'ProductsService');
throw Exception('Failed to fetch products: ${e.message}');
} catch (e) {
developer.log('❌ Unexpected error: $e', name: 'ProductsService');
throw Exception('Unexpected error occurred: $e');
}
}