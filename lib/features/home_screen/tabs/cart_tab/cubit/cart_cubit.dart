import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/cart_service.dart';
import '../data/models/cart.dart';
import 'cart_state.dart';
import 'dart:developer' as developer;

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  String? _userToken;

  Future<void> _getUserToken() async {
    if (_userToken == null) {
      final prefs = await SharedPreferences.getInstance();
      _userToken = prefs.getString('token');
    }
  }

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _userToken = null;
  }

  Future<void> loadCart() async {
    emit(CartLoading());

    try {
      await _getUserToken();

      if (_userToken == null || _userToken!.isEmpty) {
        emit(CartEmpty());
        return;
      }

      final cart = await CartService.getLoggedUserCart(_userToken!);

      if (cart.items.isEmpty) {
        emit(CartEmpty());
      } else {
        emit(CartLoaded(cart));
      }
    } on Exception catch (e) {
      developer.log('❌ Error loading cart: $e', name: 'CartCubit');

      if (e.toString().contains('Token expired') ||
          e.toString().contains('Expired Token') ||
          e.toString().contains('login again') ||
          e.toString().contains('401')) {

        await _clearToken();
        emit(CartEmpty());
      } else {
        emit(CartError('Failed to load cart: ${e.toString()}'));
      }
    } catch (e) {
      developer.log('❌ Unexpected error: $e', name: 'CartCubit');
      emit(CartError('Failed to load cart: ${e.toString()}'));
    }
  }

  Future<void> refreshCart() async {
    await loadCart();
  }

  Future<void> increaseQuantity(String cartItemId, int currentQuantity) async {
    try {
      await _getUserToken();

      if (_userToken == null || _userToken!.isEmpty) {
        emit(CartError('Please login to continue', isAuthError: true));
        return;
      }

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
    } on Exception catch (e) {
      developer.log('❌ Error increasing quantity: $e', name: 'CartCubit');

      if (e.toString().contains('Token expired') ||
          e.toString().contains('Expired Token') ||
          e.toString().contains('login again') ||
          e.toString().contains('401')) {

        await _clearToken();
        emit(CartError('Session expired. Please login again.', isAuthError: true));
      } else {
        // Revert to previous state on error
        if (state is CartUpdating) {
          final previousState = (state as CartUpdating).cart;
          emit(CartLoaded(previousState));
        }
        rethrow;
      }
    }
  }

  Future<void> decreaseQuantity(String cartItemId, int currentQuantity) async {
    if (currentQuantity <= 1) return;

    try {
      await _getUserToken();

      if (_userToken == null || _userToken!.isEmpty) {
        emit(CartError('Please login to continue', isAuthError: true));
        return;
      }

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
    } on Exception catch (e) {
      developer.log('❌ Error decreasing quantity: $e', name: 'CartCubit');

      if (e.toString().contains('Token expired') ||
          e.toString().contains('Expired Token') ||
          e.toString().contains('login again') ||
          e.toString().contains('401')) {

        await _clearToken();
        emit(CartError('Session expired. Please login again.', isAuthError: true));
      } else {
        // Revert to previous state on error
        if (state is CartUpdating) {
          final previousState = (state as CartUpdating).cart;
          emit(CartLoaded(previousState));
        }
        rethrow;
      }
    }
  }

  Future<void> removeItem(String cartItemId) async {
    try {
      await _getUserToken();

      if (_userToken == null || _userToken!.isEmpty) {
        emit(CartError('Please login to continue', isAuthError: true));
        return;
      }

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
    } on Exception catch (e) {
      developer.log('❌ Error removing item: $e', name: 'CartCubit');

      if (e.toString().contains('Token expired') ||
          e.toString().contains('Expired Token') ||
          e.toString().contains('login again') ||
          e.toString().contains('401')) {

        await _clearToken();
        emit(CartError('Session expired. Please login again.', isAuthError: true));
      } else {
        // Revert to previous state on error
        if (state is CartUpdating) {
          final previousState = (state as CartUpdating).cart;
          emit(CartLoaded(previousState));
        }
        rethrow;
      }
    }
  }
}