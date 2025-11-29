
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String? brand;
  final String? category;
  final int? stock;
  final double? rating;
  final int? ratingsQuantity;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.brand,
    this.category,
    this.stock,
    this.rating,
    this.ratingsQuantity,
  });


  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['title'] ?? json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['imageCover'] ?? json['image'] ?? '',
      brand: json['brand']?['name'] ?? json['brand'],
      category: json['category']?['name'] ?? json['category'],
      stock: json['quantity'] ?? json['stock'],
      rating: (json['ratingsAverage'] ?? 0).toDouble(),
      ratingsQuantity: json['ratingsQuantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': name,
      'description': description,
      'price': price,
      'imageCover': imageUrl,
      'brand': brand,
      'category': category,
      'quantity': stock,
      'ratingsAverage': rating,
      'ratingsQuantity': ratingsQuantity,
    };
  }

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? brand,
    String? category,
    int? stock,
    double? rating,
    int? ratingsQuantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      stock: stock ?? this.stock,
      rating: rating ?? this.rating,
      ratingsQuantity: ratingsQuantity ?? this.ratingsQuantity,
    );
  }
}