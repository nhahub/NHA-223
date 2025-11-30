abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<dynamic> products;
  final bool hasMore;

  ProductsLoaded({required this.products, this.hasMore = false});
}

class ProductsEmpty extends ProductsState {}

class ProductsError extends ProductsState {
  final String message;
  final bool isAuthError;

  ProductsError(this.message, {this.isAuthError = false});
}