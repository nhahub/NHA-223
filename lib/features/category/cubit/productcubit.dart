import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

import 'ProductsService.dart';
import 'ProductsService.dart' as ProductsService;
import 'ProductsStates.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  String? _userToken;
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  List<dynamic> _allProducts = [];

  Future<void> _getUserToken() async {
    if (_userToken == null) {
      final prefs = await SharedPreferences.getInstance();
      _userToken = prefs.getString('token');
    }
  }

  Future<void> loadAllProducts() async {
    emit(ProductsLoading());

    try {
      await _getUserToken();

      final response = await ProductsService.getAllProducts(page: 1);

      _allProducts = response['data'];
      _hasMore = response['hasMore'] ?? false;
      _currentPage = 1;

      if (_allProducts.isEmpty) {
        emit(ProductsEmpty());
      } else {
        emit(ProductsLoaded(
          products: _allProducts,
          hasMore: _hasMore,
        ));
      }
    } on Exception catch (e) {
      developer.log('❌ Error loading products: $e', name: 'ProductsCubit');

      // التحقق من خطأ Token Expired
      if (e.toString().contains('Token expired') ||
          e.toString().contains('Expired Token') ||
          e.toString().contains('login again') ||
          e.toString().contains('401')) {

        await _clearToken();
        emit(ProductsError('Session expired. Please login again.', isAuthError: true));
      } else {
        emit(ProductsError('Failed to load products: ${e.toString()}'));
      }
    } catch (e) {
      developer.log('❌ Unexpected error: $e', name: 'ProductsCubit');
      emit(ProductsError('Failed to load products: ${e.toString()}'));
    }
  }

  Future<void> loadMoreProducts() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;

    try {
      await _getUserToken();

      final nextPage = _currentPage + 1;
      final response = await ProductsService.getAllProducts(page: nextPage);

      final newProducts = response['data'];
      _hasMore = response['hasMore'] ?? false;
      _currentPage = nextPage;

      _allProducts.addAll(newProducts);

      emit(ProductsLoaded(
        products: List.from(_allProducts),
        hasMore: _hasMore,
      ));

    } catch (e) {
      _currentPage--; // تراجع عن زيادة الصفحة في حالة الخطأ
      developer.log('❌ Error loading more products: $e', name: 'ProductsCubit');
      // لا تعمل emit للخطأ علشان متخربش الـ UI
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> loadProductsByCategory(String categoryId) async {
    emit(ProductsLoading());

    try {
      await _getUserToken();

      if (_userToken == null || _userToken!.isEmpty) {
        emit(ProductsEmpty());
        return;
      }


    } on Exception catch (e) {
      developer.log('❌ Error loading category products: $e', name: 'ProductsCubit');

      if (e.toString().contains('Token expired') ||
          e.toString().contains('Expired Token') ||
          e.toString().contains('login again') ||
          e.toString().contains('401')) {

        await _clearToken();
        emit(ProductsError('Session expired. Please login again.', isAuthError: true));
      } else {
        emit(ProductsError('Failed to load category products: ${e.toString()}'));
      }
    } catch (e) {
      developer.log('❌ Unexpected error: $e', name: 'ProductsCubit');
      emit(ProductsError('Failed to load category products: ${e.toString()}'));
    }
  }

  Future<void> refreshProducts() async {
    _currentPage = 1;
    _hasMore = true;
    _allProducts = [];
    await loadAllProducts();
  }

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _userToken = null;
  }
}