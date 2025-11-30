import 'cart_item.dart';

class Cart {
  final String? id;
  final List<CartItem> items;
  final int numOfCartItems;
  final double totalCartPrice;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Cart({
    this.id,
    required this.items,
    required this.numOfCartItems,
    required this.totalCartPrice,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    try {
      final data = json['data'] ?? json;

      List<CartItem> cartItems = [];
      if (data['products'] != null) {
        final productsData = data['products'];
        if (productsData is List) {
          cartItems = productsData
              .map((item) {
            try {
              return CartItem.fromJson(item as Map<String, dynamic>);
            } catch (e) {
              print('❌ Error parsing cart item: $e');
              return null;
            }
          })
              .where((item) => item != null)
              .cast<CartItem>()
              .toList();
        }
      } else if (data['items'] != null) {
        // دعم للتنسيق البديل
        final itemsData = data['items'];
        if (itemsData is List) {
          cartItems = itemsData
              .map((item) {
            try {
              return CartItem.fromJson(item as Map<String, dynamic>);
            } catch (e) {
              print('❌ Error parsing cart item: $e');
              return null;
            }
          })
              .where((item) => item != null)
              .cast<CartItem>()
              .toList();
        }
      }

      // تحويل القيم بشكل آمن
      int numItems = 0;
      if (data['numOfCartItems'] != null) {
        numItems = int.tryParse(data['numOfCartItems'].toString()) ?? cartItems.length;
      } else if (data['totalQuantity'] != null) {
        numItems = int.tryParse(data['totalQuantity'].toString()) ?? cartItems.length;
      } else {
        numItems = cartItems.length;
      }

      double totalPrice = 0.0;
      if (data['totalCartPrice'] != null) {
        totalPrice = double.tryParse(data['totalCartPrice'].toString()) ?? 0.0;
      } else if (data['totalPrice'] != null) {
        totalPrice = double.tryParse(data['totalPrice'].toString()) ?? 0.0;
      }

      return Cart(
        id: data['_id']?.toString() ?? data['id']?.toString(),
        items: cartItems,
        numOfCartItems: numItems,
        totalCartPrice: totalPrice,
        userId: data['cartOwner']?.toString() ?? data['userId']?.toString(),
        createdAt: data['createdAt'] != null
            ? DateTime.tryParse(data['createdAt'].toString())
            : null,
        updatedAt: data['updatedAt'] != null
            ? DateTime.tryParse(data['updatedAt'].toString())
            : null,
      );
    } catch (e) {
      print('❌ Error in Cart.fromJson: $e');
      print('JSON data: $json');
      // في حالة حدوث خطأ، أرجع كارت فارغ
      return Cart.empty();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'products': items.map((item) => item.toJson()).toList(),
      'numOfCartItems': numOfCartItems,
      'totalCartPrice': totalCartPrice,
      'cartOwner': userId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;
  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  int get totalItems => items.fold(0, (sum, item) => sum + item.count);

  factory Cart.empty() {
    return Cart(
      items: [],
      numOfCartItems: 0,
      totalCartPrice: 0.0,
    );
  }
}