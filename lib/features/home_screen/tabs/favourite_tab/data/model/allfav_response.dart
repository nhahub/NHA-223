class AllFavResponse {
  final String status;
  final int count;
  final List<WishlistProduct> data;

  AllFavResponse({
    required this.status,
    required this.count,
    required this.data,
  });

  factory AllFavResponse.fromJson(Map<String, dynamic> json) {
    return AllFavResponse(
      status: json['status'],
      count: json['count'],
      data: (json['data'] as List)
          .map((product) => WishlistProduct.fromJson(product))
          .toList(),
    );
  }
}

class WishlistProduct {
  final String id;
  final String title;
  final String description;
  final int quantity;
  final int price;
  final List<String> images;
  final String imageCover;
  final Category category;
  final Brand brand;
  final double ratingsAverage;
  final int ratingsQuantity;
  final int sold;

  WishlistProduct({
    required this.id,
    required this.title,
    required this.description,
    required this.quantity,
    required this.price,
    required this.images,
    required this.imageCover,
    required this.category,
    required this.brand,
    required this.ratingsAverage,
    required this.ratingsQuantity,
    required this.sold,
  });

  factory WishlistProduct.fromJson(Map<String, dynamic> json) {
    return WishlistProduct(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      quantity: (json['quantity'] ?? 0).toInt(),
      price: (json['price'] ?? 0).toInt(),
      images: List<String>.from(json['images'] ?? []),
      imageCover: json['imageCover'] ?? '',
      category: Category.fromJson(json['category'] ?? {}),
      brand: Brand.fromJson(json['brand'] ?? {}),
      ratingsAverage: (json['ratingsAverage'] ?? 0.0).toDouble(),
      ratingsQuantity: (json['ratingsQuantity'] ?? 0).toInt(),
      sold: (json['sold'] ?? 0).toInt(),
    );
  }
}

class Category {
  final String id;
  final String name;
  final String slug;
  final String image;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class Brand {
  final String id;
  final String name;
  final String slug;
  final String image;

  Brand({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
