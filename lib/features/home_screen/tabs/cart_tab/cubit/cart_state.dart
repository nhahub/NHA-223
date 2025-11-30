import '../data/models/cart.dart';

abstract class CartState {
  const CartState();
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  // final Cart cart;
  // const CartLoaded(this.cart);
}

class CartEmpty extends CartState {
  const CartEmpty();
}

class CartError extends CartState {
  final String message;
  final bool isAuthError;

  const CartError(this.message, {this.isAuthError = false});
}

class CartUpdating extends CartState {
  // final Cart cart;
  // const CartUpdating(this.cart);
}