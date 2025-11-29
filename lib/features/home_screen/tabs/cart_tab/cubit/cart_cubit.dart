import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/cart_service.dart';
import '../data/models/cart.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  String? _userToken;

  Future<void> _getUserToken() async {
    if (_userToken == null) {
      final prefs = await SharedPreferences.getInstance();
      _userToken = prefs.getString('token');
    }
  }

  Future<void> loadCart() async {
    emit(CartLoading());

    try {
      await _getUserToken();

      if (_userToken == null || _userToken!.isEmpty) {
        emit(CartError('Please login to view your cart', isAuthError: true));
        return;
      }

      final cart = await CartService.getLoggedUserCart(_userToken!);

      if (cart.items.isEmpty) {
        emit(CartEmpty());
      } else {
        emit(CartLoaded(cart));
      }
    } catch (e) {
      emit(CartError('Failed to load cart: ${e.toString()}'));
    }
  }

  Future<void> refreshCart() async {
    await loadCart();
  }

  Future<void> increaseQuantity(String cartItemId, int currentQuantity) async {
    try {
      await _getUserToken();
      if (_userToken == null) return;

      final currentState = state;
      if (currentState is CartLoaded) {
        emit(CartUpdating(currentState.cart));

        final updatedCart = await CartService.updateCartItemQuantity(
          token: _userToken!,
          cartItemId: cartItemId,
          quantity: currentQuantity + 1,
        );

        emit(CartLoaded(updatedCart));
      }
    } catch (e) {
      // Revert to previous state on error
      if (state is CartUpdating) {
        final previousState = (state as CartUpdating).cart;
        emit(CartLoaded(previousState));
      }
      rethrow;
    }
  }

  Future<void> decreaseQuantity(String cartItemId, int currentQuantity) async {
    if (currentQuantity <= 1) return;

    try {
      await _getUserToken();
      if (_userToken == null) return;

      final currentState = state;
      if (currentState is CartLoaded) {
        emit(CartUpdating(currentState.cart));

        final updatedCart = await CartService.updateCartItemQuantity(
          token: _userToken!,
          cartItemId: cartItemId,
          quantity: currentQuantity - 1,
        );

        emit(CartLoaded(updatedCart));
      }
    } catch (e) {
      // Revert to previous state on error
      if (state is CartUpdating) {
        final previousState = (state as CartUpdating).cart;
        emit(CartLoaded(previousState));
      }
      rethrow;
    }
  }

  Future<void> removeItem(String cartItemId) async {
    try {
      await _getUserToken();
      if (_userToken == null) return;

      final currentState = state;
      if (currentState is CartLoaded) {
        emit(CartUpdating(currentState.cart));

        final updatedCart = await CartService.removeFromCart(
          token: _userToken!,
          cartItemId: cartItemId,
        );

        if (updatedCart.items.isEmpty) {
          emit(CartEmpty());
        } else {
          emit(CartLoaded(updatedCart));
        }
      }
    } catch (e) {
      // Revert to previous state on error
      if (state is CartUpdating) {
        final previousState = (state as CartUpdating).cart;
        emit(CartLoaded(previousState));
      }
      rethrow;
    }
  }
}