// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'data/models/cart.dart';
// import 'data/models/cart_item.dart';
// import 'data/models/product.dart';
//
// class LocalCartService {
//   static const String _cartKey = 'local_cart';
//
//   static Future<bool> saveCart(Cart cart) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final cartJson = jsonEncode(cart.toJson());
//       return await prefs.setString(_cartKey, cartJson);
//     } catch (e) {
//
//       return false;
//     }
//   }
//
//   static Future<Cart> getCart() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final cartJson = prefs.getString(_cartKey);
//
//       if (cartJson == null || cartJson.isEmpty) {
//         return Cart.empty();
//       }
//
//       final cartMap = jsonDecode(cartJson) as Map<String, dynamic>;
//       return Cart.fromJson(cartMap);
//     } catch (e) {
//
//       print('Stack trace: ${StackTrace.current}');
//       await clearCart();
//       return Cart.empty();
//     }
//   }
//
//   static Future<Cart> addToCart(Map<String, dynamic> productData) async {
//     try {
//
//       Cart currentCart = await getCart();
//
//       Product product = Product.fromJson(productData);
//
//       int existingIndex = currentCart.items.indexWhere(
//               (item) => item.product.id == product.id
//       );
//
//       if (existingIndex != -1) {
//
//         currentCart.items[existingIndex].count++;
//       } else {
//
//         CartItem newItem = CartItem(
//           id: DateTime.now().millisecondsSinceEpoch.toString(),
//           product: product,
//           count: 1,
//           price: product.price,
//         );
//         currentCart.items.add(newItem);
//       }
//
//       double totalPrice = currentCart.items.fold(
//           0.0,
//               (sum, item) => sum + item.totalPrice
//       );
//
//       int totalItems = currentCart.items.fold(
//           0,
//               (sum, item) => sum + item.count
//       );
//
//       Cart updatedCart = Cart(
//         id: currentCart.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
//         items: currentCart.items,
//         numOfCartItems: totalItems,
//         totalCartPrice: totalPrice,
//         userId: currentCart.userId,
//         createdAt: currentCart.createdAt ?? DateTime.now(),
//         updatedAt: DateTime.now(),
//       );
//
//       await saveCart(updatedCart);
//
//       return updatedCart;
//     } catch (e) {
//
//       rethrow;
//     }
//   }
//
//   static Future<Cart> removeFromCart(String productId) async {
//     try {
//       Cart currentCart = await getCart();
//
//       currentCart.items.removeWhere(
//               (item) => item.product.id == productId
//       );
//
//       double totalPrice = currentCart.items.fold(
//           0.0,
//               (sum, item) => sum + item.totalPrice
//       );
//
//       int totalItems = currentCart.items.fold(
//           0,
//               (sum, item) => sum + item.count
//       );
//
//       Cart updatedCart = Cart(
//         id: currentCart.id,
//         items: currentCart.items,
//         numOfCartItems: totalItems,
//         totalCartPrice: totalPrice,
//         userId: currentCart.userId,
//         createdAt: currentCart.createdAt,
//         updatedAt: DateTime.now(),
//       );
//
//       await saveCart(updatedCart);
//
//       return updatedCart;
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   static Future<Cart> updateQuantity(String productId, int newQuantity) async {
//     try {
//       Cart currentCart = await getCart();
//
//       int index = currentCart.items.indexWhere(
//               (item) => item.product.id == productId
//       );
//
//       if (index != -1) {
//         if (newQuantity <= 0) {
//           currentCart.items.removeAt(index);
//         } else {
//           currentCart.items[index].count = newQuantity;
//         }
//
//         double totalPrice = currentCart.items.fold(
//             0.0,
//                 (sum, item) => sum + item.totalPrice
//         );
//
//         int totalItems = currentCart.items.fold(
//             0,
//                 (sum, item) => sum + item.count
//         );
//
//         Cart updatedCart = Cart(
//           id: currentCart.id,
//           items: currentCart.items,
//           numOfCartItems: totalItems,
//           totalCartPrice: totalPrice,
//           userId: currentCart.userId,
//           createdAt: currentCart.createdAt,
//           updatedAt: DateTime.now(),
//         );
//
//         await saveCart(updatedCart);
//
//         return updatedCart;
//       }
//
//       return currentCart;
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   static Future<bool> clearCart() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       return await prefs.remove(_cartKey);
//     } catch (e) {
//       print('❌ Error clearing cart: $e');
//       return false;
//     }
//   }
//   static Future<bool> isProductInCart(String productId) async {
//     try {
//       Cart cart = await getCart();
//       return cart.items.any((item) => item.product.id == productId);
//     } catch (e) {
//       return false;
//     }
//   }
//
//   static Future<int> getCartItemsCount() async {
//     try {
//       Cart cart = await getCart();
//       return cart.numOfCartItems;
//     } catch (e) {
//       return 0;
//     }
//   }
// }