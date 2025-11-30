import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:final_depi_project/core/api_constant.dart';
import 'package:final_depi_project/core/dio_helper.dart';
import 'package:flutter/foundation.dart';

import '../model/get_catogries_response.dart';
import '../model/get_all_product_response.dart';

class HomeRepository {
  Future<CategoriesResponse> getAllCategories() async {
    try {
      final response = await DioHelper.get(
        ApiConstant.categoriesEndPoint,
      );
      
      return CategoriesResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            e.response?.data['message'] ?? 'Failed to load categories');
      } else {
        throw Exception('Network Error: ${e.message}');
      }
    }
  }

  Future<ProductResponse> getProducts() async {
    try {
      final response = await DioHelper.get(
        ApiConstant.productEndPoint,
      );
      // var result = await compute(productResponseFromJson, jsonEncode(response.data));
      return ProductResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to load products');
      } else {
        throw Exception('Network Error: ${e.message}');
      }
    }
  }

  Future<Product> getProductById(String id) async {
    try {
      final response = await DioHelper.get(
        "${ApiConstant.productEndPoint}/$id",
      );

      return Product.fromJson(response.data['data']);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to load product');
      } else {
        throw Exception('Network Error: ${e.message}');
      }
    }
  }




  ProductResponse productResponseFromJson(String str) =>
      ProductResponse.fromJson(json.decode(str));
}
