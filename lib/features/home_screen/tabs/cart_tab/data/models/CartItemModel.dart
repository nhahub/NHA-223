class CartItem {
  final String? id;
  final int count;
  final String? productId;
  final int price;
  final String? image;
  final String? title;
  final String? color;
  final String? size;

  CartItem({
    this.id,
    required this.count,
    this.productId,
    required this.price,
    this.image,
    this.title,
    this.color,
    this.size,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    print('🔄 Parsing CartItem: $json');

    String? prodId;
    String? image;
    String? title;
    String? color;
    String? size;

    if (json['product'] != null) {
      if (json['product'] is Map<String, dynamic>) {
        final productData = json['product'];
        prodId = productData['_id'] ?? productData['id'];

        image = productData['imageCover'] ??
            productData['image'] ??
            (productData['images'] != null && productData['images'].isNotEmpty ? productData['images'][0] : '');

        title = productData['title'] ?? productData['name'] ?? 'Unknown Product';
        color = productData['color'] ?? 'Default';
        size = productData['size'] ?? 'M';

        print('✅ Extracted product data - ID: $prodId, Image: $image, Title: $title');
      } else if (json['product'] is String) {
        prodId = json['product'];
        image = '';
        title = 'Product $prodId';
        color = 'Default';
        size = 'M';
      }
    }

    if (image == null || image.isEmpty) {
      image = json['image'] ?? json['imageCover'] ?? '';
    }

    if (title == null || title.isEmpty) {
      title = json['title'] ?? json['productTitle'] ?? 'Unknown Product';
    }

    return CartItem(
      id: json['_id'],
      count: json['count'] ?? 0,
      productId: prodId ?? json['productId'],
      price: json['price'] ?? 0,
      image: image,
      title: title,
      color: color,
      size: size,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'count': count,
      'product': productId,
      'price': price,
    };
  }

  String get imageUrl => image ?? '';
  String get productTitle => title ?? 'Product $productId';
  int get qty => count;
  double get priceDouble => price.toDouble();
  String get productColor => color ?? 'Default';
  String get productSize => size ?? 'M';
}