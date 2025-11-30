import '../data/model/get_all_product_response.dart';
import '../data/model/get_catogries_response.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetCategoriesLoading extends HomeState {}

class GetCategoriesSuccess extends HomeState {
  final CategoriesResponse categories;

  GetCategoriesSuccess(this.categories);
}

class GetCategoriesError extends HomeState {
  final String message;

  GetCategoriesError(this.message);
}

class ProductsLoading extends HomeState {}

class ProductsLoaded extends HomeState {
  final Map<String, List<Product>> productsByCategory;

  ProductsLoaded({ required this.productsByCategory});
}

class ProductsError extends HomeState {
  final String message;

  ProductsError(this.message);
}
