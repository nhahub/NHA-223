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
    final data = json['data'] ?? json;

    List<CartItem> cartItems = [];
    if (data['products'] != null) {
      cartItems = (data['products'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList();
    }

    return Cart(
      id: data['_id'] ?? data['id'],
      items: cartItems,
      numOfCartItems: data['numOfCartItems'] ?? data['totalQuantity'] ?? cartItems.length,
      totalCartPrice: (data['totalCartPrice'] ?? data['totalPrice'] ?? 0).toDouble(),
      userId: data['cartOwner'] ?? data['userId'],
      createdAt: data['createdAt'] != null
          ? DateTime.tryParse(data['createdAt'])
          : null,
      updatedAt: data['updatedAt'] != null
          ? DateTime.tryParse(data['updatedAt'])
          : null,
    );
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