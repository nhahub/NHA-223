// CartItemModel.dart بدون استيراد shared_pref.dart
class CartItem {
  final String id;
  final int count;
  final String productId;
  final int price;
  final String image;
  final String title;
  final String? color;
  final String? size;

  CartItem({
    required this.id,
    required this.count,
    required this.productId,
    required this.price,
    required this.image,
    required this.title,
    this.color,
    this.size,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    final productData = json['product'] is Map<String, dynamic>
        ? json['product'] as Map<String, dynamic>
        : <String, dynamic>{};

    return CartItem(
      id: _toString(json['_id']) ?? _toString(json['id']) ?? '',
      count: _toInt(json['count']) ?? 1,
      productId: _toString(productData['id']) ?? _toString(json['product']) ?? '',
      price: _toInt(productData['price']) ?? _toInt(json['price']) ?? 0,
      image: _toString(productData['imageCover']) ??
          _toString(productData['image']) ??
          _toString(json['image']) ??
          '',
      title: _toString(productData['title']) ??
          _toString(productData['name']) ??
          _toString(json['title']) ??
          '',
      color: _toString(json['color'] ?? productData['color']),
      size: _toString(json['size'] ?? productData['size']),
    );
  }

  static String? _toString(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'count': count,
      'product': productId,
      'price': price,
      'image': image,
      'title': title,
      'color': color,
      'size': size,
    };
  }

  // Getters
  String get imageUrl => image;
  String get productTitle => title;
  double get priceDouble => price.toDouble();
  int get qty => count;
  String? get productColor => color;
  String? get productSize => size;
}