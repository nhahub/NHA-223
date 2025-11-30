import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/CartRepository.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _repository;

  CartCubit(this._repository) : super(CartInitial());

  Future<void> loadCart() async {
    emit(CartLoading());
    try {
      final cart = await _repository.getCart();
      if (cart.items == null || cart.items!.isEmpty) {
        emit(CartEmpty());
      } else {
        emit(CartLoaded(cart));
      }
    } catch (e) {
      if (e.toString().contains('Cart not found')) {
        emit(CartEmpty());
      } else {
        emit(CartError(e.toString()));
      }
    }
  }

  Future<void> increaseQuantity(String productId, int currentCount) async {
    final currentState = state;
    if (currentState is CartLoaded) {
      emit(CartUpdating(currentState.cart));
      try {
        final updatedCart = await _repository.updateQuantity(
          productId,
          currentCount + 1,
        );
        emit(CartLoaded(updatedCart));
      } catch (e) {
        emit(CartLoaded(currentState.cart));
        emit(CartError('Failed to increase quantity'));
      }
    }
  }

  Future<void> decreaseQuantity(String productId, int currentCount) async {
    final currentState = state;
    if (currentState is CartLoaded) {
      if (currentCount <= 1) {
        await removeItem(productId);
        return;
      }

      emit(CartUpdating(currentState.cart));
      try {
        final updatedCart = await _repository.updateQuantity(
          productId,
          currentCount - 1,
        );
        emit(CartLoaded(updatedCart));
      } catch (e) {
        emit(CartLoaded(currentState.cart));
        emit(CartError('Failed to decrease quantity'));
      }
    }
  }

  Future<void> removeItem(String productId) async {
    final currentState = state;
    if (currentState is CartLoaded) {
      emit(CartUpdating(currentState.cart));
      try {
        final updatedCart = await _repository.removeItem(productId);
        if (updatedCart.items == null || updatedCart.items!.isEmpty) {
          emit(CartEmpty());
        } else {
          emit(CartLoaded(updatedCart));
        }
      } catch (e) {
        emit(CartLoaded(currentState.cart));
        emit(CartError('Failed to remove item'));
      }
    }
  }

  Future<void> addToCart(String productId) async {
    final currentState = state;

    if (currentState is CartEmpty || currentState is CartInitial) {
      emit(CartLoading());
    }
    else if (currentState is CartLoaded) {
      emit(CartUpdating(currentState.cart));
    }

    try {
      await _repository.addToCart(productId);

      await loadCart();
    } catch (e) {
      if (currentState is CartLoaded) {
        emit(CartLoaded(currentState.cart));
      } else if (currentState is CartEmpty) {
        emit(CartEmpty());
      }
      emit(CartError('Failed to add item to cart'));
    }
  }

  Future<void> clearCart() async {
    final currentState = state;
    if (currentState is CartLoaded) {
      emit(CartUpdating(currentState.cart));
      try {
        await _repository.clearCart();
        emit(CartEmpty());
      } catch (e) {
        emit(CartLoaded(currentState.cart));
        emit(CartError('Failed to clear cart'));
      }
    }
  }

  Future<void> refreshCart() async {
    await loadCart();
  }
}