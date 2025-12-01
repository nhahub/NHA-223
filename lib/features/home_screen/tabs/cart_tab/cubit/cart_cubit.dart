import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/CartRepository.dart';
import '../data/models/cartmodel.dart';
import '../data/models/CartItemModel.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _repository;

  CartCubit(this._repository) : super(CartInitial());

  void resetCart() {
    emit(CartInitial());
  }

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
    if (currentState is! CartLoaded) return;

    try {
      final updatedItems = currentState.cart.items?.map((item) {
        if (item.productId == productId) {
          return CartItem(
            id: item.id,
            count: item.count + 1,
            productId: item.productId,
            price: item.price,
            image: item.image,
            title: item.title,
            color: item.color,
            size: item.size,
          );
        }
        return item;
      }).toList();

      final newTotal = updatedItems?.fold<int>(
        0,
            (sum, item) => sum + (item.price * item.count),
      ) ?? 0;

      final optimisticCart = CartModel(
        id: currentState.cart.id,
        cartOwner: currentState.cart.cartOwner,
        items: updatedItems,
        createdAt: currentState.cart.createdAt,
        updatedAt: currentState.cart.updatedAt,
        totalCartPrice: newTotal,
        numOfCartItems: currentState.cart.numOfCartItems,
      );

      emit(CartLoaded(optimisticCart));

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

  Future<void> decreaseQuantity(String productId, int currentCount) async {
    final currentState = state;
    if (currentState is! CartLoaded) return;

    if (currentCount <= 1) {
      await removeItem(productId);
      return;
    }

    try {
      final updatedItems = currentState.cart.items?.map((item) {
        if (item.productId == productId) {
          return CartItem(
            id: item.id,
            count: item.count - 1,
            productId: item.productId,
            price: item.price,
            image: item.image,
            title: item.title,
            color: item.color,
            size: item.size,
          );
        }
        return item;
      }).toList();

      final newTotal = updatedItems?.fold<int>(
        0,
            (sum, item) => sum + (item.price * item.count),
      ) ?? 0;

      final optimisticCart = CartModel(
        id: currentState.cart.id,
        cartOwner: currentState.cart.cartOwner,
        items: updatedItems,
        createdAt: currentState.cart.createdAt,
        updatedAt: currentState.cart.updatedAt,
        totalCartPrice: newTotal,
        numOfCartItems: currentState.cart.numOfCartItems,
      );

      // 🔥 2. نعرض فوراً
      emit(CartLoaded(optimisticCart));

      // 🔥 3. API call في الخلفية
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
      }
    }
  }

  Future<void> addToCart(String productId) async {
    try {
      await _repository.addToCart(productId);
    } catch (e) {
      throw Exception('Failed to add item to cart');
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
      }
    }
  }

  Future<void> refreshCart() async {
    await loadCart();
  }
}