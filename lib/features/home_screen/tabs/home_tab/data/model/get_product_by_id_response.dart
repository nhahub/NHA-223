class GetProductByIdResponse {
  final ProductData data;

  GetProductByIdResponse({required this.data});

  factory GetProductByIdResponse.fromJson(Map<String, dynamic> json) {
    return GetProductByIdResponse(
      data: ProductData.fromJson(json['data']),
    );
  }
}

class ProductData {
  final int sold;
  final List<String> images;
  final List<SubCategory> subcategory;
  final int ratingsQuantity;
  final String id;
  final String title;
  final String slug;
  final String description;
  final int quantity;
  final int price;
  final String imageCover;
  final Category category;
  final Brand brand;
  final double ratingsAverage;
  final String createdAt;
  final String updatedAt;
  final List<dynamic> reviews;

  ProductData({
    required this.sold,
    required this.images,
    required this.subcategory,
    required this.ratingsQuantity,
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.quantity,
    required this.price,
    required this.imageCover,
    required this.category,
    required this.brand,
    required this.ratingsAverage,
    required this.createdAt,
    required this.updatedAt,
    required this.reviews,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      sold: json['sold'],
      images: List<String>.from(json['images']),
      subcategory: (json['subcategory'] as List)
          .map((e) => SubCategory.fromJson(e))
          .toList(),
      ratingsQuantity: json['ratingsQuantity'],
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      quantity: json['quantity'],
      price: json['price'],
      imageCover: json['imageCover'],
      category: Category.fromJson(json['category']),
      brand: Brand.fromJson(json['brand']),
      ratingsAverage: (json['ratingsAverage'] as num).toDouble(),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      reviews: json['reviews'] ?? [],
    );
  }
}

class SubCategory {
  final String id;
  final String name;
  final String slug;
  final String category;

  SubCategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.category,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      category: json['category'],
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
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
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
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
    );
  }
}
