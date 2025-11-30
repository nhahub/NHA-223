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
    try {
      // استخراج القيم بشكل آمن
      String productId = '';
      if (json['_id'] != null) {
        productId = json['_id'].toString();
      } else if (json['id'] != null) {
        productId = json['id'].toString();
      }

      String productName = '';
      if (json['title'] != null) {
        productName = json['title'].toString();
      } else if (json['name'] != null) {
        productName = json['name'].toString();
      }

      String productDescription = '';
      if (json['description'] != null) {
        productDescription = json['description'].toString();
      }

      double productPrice = 0.0;
      if (json['price'] != null) {
        productPrice = double.tryParse(json['price'].toString()) ?? 0.0;
      }

      String productImage = '';
      if (json['imageCover'] != null) {
        productImage = json['imageCover'].toString();
      } else if (json['image'] != null) {
        productImage = json['image'].toString();
      }

      String? productBrand;
      if (json['brand'] != null) {
        if (json['brand'] is Map) {
          productBrand = json['brand']['name']?.toString();
        } else {
          productBrand = json['brand'].toString();
        }
      }

      String? productCategory;
      if (json['category'] != null) {
        if (json['category'] is Map) {
          productCategory = json['category']['name']?.toString();
        } else {
          productCategory = json['category'].toString();
        }
      }

      int? productStock;
      if (json['quantity'] != null) {
        productStock = int.tryParse(json['quantity'].toString());
      } else if (json['stock'] != null) {
        productStock = int.tryParse(json['stock'].toString());
      }

      double? productRating;
      if (json['ratingsAverage'] != null) {
        productRating = double.tryParse(json['ratingsAverage'].toString());
      }

      int? ratingsQty;
      if (json['ratingsQuantity'] != null) {
        ratingsQty = int.tryParse(json['ratingsQuantity'].toString());
      }

      return Product(
        id: productId,
        name: productName,
        description: productDescription,
        price: productPrice,
        imageUrl: productImage,
        brand: productBrand,
        category: productCategory,
        stock: productStock,
        rating: productRating,
        ratingsQuantity: ratingsQty,
      );
    } catch (e) {
      print('❌ Error in Product.fromJson: $e');
      print('JSON data: $json');
      rethrow;
    }
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