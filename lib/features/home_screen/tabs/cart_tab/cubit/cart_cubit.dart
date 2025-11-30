// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../LocalCartService.dart';
// import '../services/cart_service.dart';
// import '../data/models/cart.dart';
// import 'cart_state.dart';
// import 'dart:developer' as developer;
//
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
//
//   String? _userToken;
//   bool _useLocalCart = false; // للتبديل بين الكارت المحلي والسيرفر
//
//   Future<void> _getUserToken() async {
//     if (_userToken == null) {
//       final prefs = await SharedPreferences.getInstance();
//       _userToken = prefs.getString('token');
//       _useLocalCart = _userToken == null || _userToken!.isEmpty;
//     }
//   }
//
//   Future<void> _clearToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('token');
//     _userToken = null;
//     _useLocalCart = true;
//   }
//
//   Future<void> loadCart() async {
//     emit(CartLoading());
//
//     try {
//       await _getUserToken();
//
//       // Cart cart;
//       //
//       // if (_useLocalCart) {
//       //   // استخدام الكارت المحلي
//       //   cart = await LocalCartService.getCart();
//       // } else {
//       //   // استخدام الكارت من السيرفر
//       //   try {
//       //     cart = await CartService.getLoggedUserCart(_userToken!);
//       //   } catch (e) {
//       //     // في حالة فشل السيرفر، استخدم الكارت المحلي
//       //     developer.log('⚠️ Server cart failed, using local cart', name: 'CartCubit');
//       //     cart = await LocalCartService.getCart();
//       //     _useLocalCart = true;
//       //   }
//       }
//
//       if (cart.items.isEmpty) {
//         emit(CartEmpty());
//       } else {
//         emit(CartLoaded(cart));
//       }
//     } on Exception catch (e) {
//       developer.log('❌ Error loading cart: $e', name: 'CartCubit');
//
//       if (e.toString().contains('Token expired') ||
//           e.toString().contains('Expired Token') ||
//           e.toString().contains('login again') ||
//           e.toString().contains('401')) {
//
//         await _clearToken();
//         // حاول تحميل الكارت المحلي
//         final localCart = await LocalCartService.getCart();
//         if (localCart.items.isEmpty) {
//           emit(CartEmpty());
//         } else {
//           emit(CartLoaded(localCart));
//         }
//       } else {
//         emit(CartError('Failed to load cart: ${e.toString()}'));
//       }
//     } catch (e) {
//       developer.log('❌ Unexpected error: $e', name: 'CartCubit');
//
//       // في حالة أي خطأ، حاول تحميل الكارت المحلي
//       try {
//         final localCart = await LocalCartService.getCart();
//         if (localCart.items.isEmpty) {
//           emit(CartEmpty());
//         } else {
//           emit(CartLoaded(localCart));
//         }
//       } catch (e2) {
//         emit(CartError('Failed to load cart: ${e.toString()}'));
//       }
//     }
//   }
//
//   Future<void> refreshCart() async {
//     await loadCart();
//   }
//
//   Future<void> increaseQuantity(String cartItemId, int currentQuantity) async {
//     try {
//       await _getUserToken();
//
//       final currentState = state;
//       if (currentState is CartLoaded) {
//         emit(CartUpdating(currentState.cart));
//
//         Cart updatedCart;
//
//         if (_useLocalCart) {
//           // تحديث الكارت المحلي
//           final product = currentState.cart.items
//               .firstWhere((item) => item.id == cartItemId)
//               .product;
//
//           updatedCart = await LocalCartService.updateQuantity(
//             product.id,
//             currentQuantity + 1,
//           );
//         } else {
//           // تحديث الكارت في السيرفر
//           updatedCart = await CartService.updateCartItemQuantity(
//             token: _userToken!,
//             cartItemId: cartItemId,
//             quantity: currentQuantity + 1,
//           );
//         }
//
//         emit(CartLoaded(updatedCart));
//       }
//     } on Exception catch (e) {
//       developer.log('❌ Error increasing quantity: $e', name: 'CartCubit');
//
//       if (e.toString().contains('Token expired') ||
//           e.toString().contains('Expired Token') ||
//           e.toString().contains('login again') ||
//           e.toString().contains('401')) {
//
//         await _clearToken();
//         emit(CartError('Session expired. Please login again.', isAuthError: true));
//       } else {
//         if (state is CartUpdating) {
//           final previousState = (state as CartUpdating).cart;
//           emit(CartLoaded(previousState));
//         }
//         rethrow;
//       }
//     }
//   }
//
//   Future<void> decreaseQuantity(String cartItemId, int currentQuantity) async {
//     if (currentQuantity <= 1) return;
//
//     try {
//       await _getUserToken();
//
//       final currentState = state;
//       if (currentState is CartLoaded) {
//         emit(CartUpdating(currentState.cart));
//
//         Cart updatedCart;
//
//         if (_useLocalCart) {
//           final product = currentState.cart.items
//               .firstWhere((item) => item.id == cartItemId)
//               .product;
//
//           updatedCart = await LocalCartService.updateQuantity(
//             product.id,
//             currentQuantity - 1,
//           );
//         } else {
//           updatedCart = await CartService.updateCartItemQuantity(
//             token: _userToken!,
//             cartItemId: cartItemId,
//             quantity: currentQuantity - 1,
//           );
//         }
//
//         emit(CartLoaded(updatedCart));
//       }
//     } on Exception catch (e) {
//       developer.log('❌ Error decreasing quantity: $e', name: 'CartCubit');
//
//       if (e.toString().contains('Token expired') ||
//           e.toString().contains('Expired Token') ||
//           e.toString().contains('login again') ||
//           e.toString().contains('401')) {
//
//         await _clearToken();
//         emit(CartError('Session expired. Please login again.', isAuthError: true));
//       } else {
//         if (state is CartUpdating) {
//           final previousState = (state as CartUpdating).cart;
//           emit(CartLoaded(previousState));
//         }
//         rethrow;
//       }
//     }
//   }
//
//   Future<void> removeItem(String cartItemId) async {
//     try {
//       await _getUserToken();
//
//       final currentState = state;
//       if (currentState is CartLoaded) {
//         emit(CartUpdating(currentState.cart));
//
//         Cart updatedCart;
//
//         if (_useLocalCart) {
//           final product = currentState.cart.items
//               .firstWhere((item) => item.id == cartItemId)
//               .product;
//
//           updatedCart = await LocalCartService.removeFromCart(product.id);
//         } else {
//           updatedCart = await CartService.removeFromCart(
//             token: _userToken!,
//             cartItemId: cartItemId,
//           );
//         }
//
//         if (updatedCart.items.isEmpty) {
//           emit(CartEmpty());
//         } else {
//           emit(CartLoaded(updatedCart));
//         }
//       }
//     } on Exception catch (e) {
//       developer.log('❌ Error removing item: $e', name: 'CartCubit');
//
//       if (e.toString().contains('Token expired') ||
//           e.toString().contains('Expired Token') ||
//           e.toString().contains('login again') ||
//           e.toString().contains('401')) {
//
//         await _clearToken();
//         emit(CartError('Session expired. Please login again.', isAuthError: true));
//       } else {
//         if (state is CartUpdating) {
//           final previousState = (state as CartUpdating).cart;
//           emit(CartLoaded(previousState));
//         }
//         rethrow;
//       }
//     }
//   }
//
//   // دالة لمزامنة الكارت المحلي مع السيرفر عند تسجيل الدخول
//   Future<void> syncLocalCartWithServer() async {
//     try {
//       await _getUserToken();
//
//       if (_userToken == null || _userToken!.isEmpty) return;
//
//       final localCart = await LocalCartService.getCart();
//
//       if (localCart.items.isNotEmpty) {
//         developer.log('📦 Found ${localCart.items.length} items in local cart', name: 'CartCubit');
//
//         // يمكنك إضافة كود المزامنة هنا إذا كان لديك API endpoint لإضافة منتج للكارت
//         // مثال:
//         // for (var item in localCart.items) {
//         //   try {
//         //     await YourCartService.addProductToCart(
//         //       token: _userToken!,
//         //       productId: item.product.id,
//         //       quantity: item.count,
//         //     );
//         //   } catch (e) {
//         //     developer.log('⚠️ Failed to sync item: ${item.product.name}', name: 'CartCubit');
//         //   }
//         // }
//
//         // مسح الكارت المحلي بعد المزامنة
//         await LocalCartService.clearCart();
//
//         // إعادة تحميل الكارت من السيرفر
//         await loadCart();
//       }
//     } catch (e) {
//       developer.log('❌ Error syncing cart: $e', name: 'CartCubit');
//     }
//   }
}