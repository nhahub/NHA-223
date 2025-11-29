import 'product.dart';

class CartItem {
  final String? id;
  final Product product;
  int count;
  final String? color;
  final String? size;
  final double price;

  CartItem({
    this.id,
    required this.product,
    this.count = 1,
    this.color,
    this.size,
    required this.price,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['_id'] ?? json['id'],
      product: Product.fromJson(json['product'] ?? {}),
      count: json['count'] ?? json['quantity'] ?? 1,
      color: json['color'],
      size: json['size'],
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'product': product.toJson(),
      'count': count,
      'color': color,
      'size': size,
      'price': price,
    };
  }

  double get totalPrice => price * count;

  String get image => product.imageUrl;
  String get title => product.name;
  int get qty => count;
}