import 'CartItemModel.dart';

class CartModel {
  final String? id;
  final String? cartOwner;
  final List<CartItem>? items;
  final String? createdAt;
  final String? updatedAt;
  final int totalCartPrice;
  final int? numOfCartItems;

  CartModel({
    this.id,
    this.cartOwner,
    this.items,
    this.createdAt,
    this.updatedAt,
    required this.totalCartPrice,
    this.numOfCartItems,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;

    if (data == null) {
      throw Exception('Invalid cart response structure');
    }

    // استخراج العناصر
    List<CartItem>? cartItems;

    if (data['products'] != null && data['products'] is List) {
      cartItems = (data['products'] as List).map((v) {
        return CartItem.fromJson(v);
      }).toList();
    } else {
      cartItems = [];
    }

    return CartModel(
      id: data['_id'],
      cartOwner: data['cartOwner'],
      items: cartItems,
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
      totalCartPrice: data['totalCartPrice'] ?? 0,
      numOfCartItems: data['numOfCartItems'] ?? cartItems?.length ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'numOfCartItems': numOfCartItems,
      'data': {
        '_id': id,
        'cartOwner': cartOwner,
        'products': items?.map((v) => v.toJson()).toList(),
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'totalCartPrice': totalCartPrice,
      }
    };
  }
}