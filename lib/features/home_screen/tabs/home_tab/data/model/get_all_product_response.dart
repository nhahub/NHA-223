



class ProductResponse {
  final int? results;
  final Metadata? metadata;
  final List<Product>? data;

  ProductResponse({
    this.results,
    this.metadata,
    this.data,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      results: json['results'],
      metadata: json['metadata'] != null
          ? Metadata.fromJson(json['metadata'])
          : null,
      // Safely parse the list of products
      data: json['data'] != null && json['data'] is List
          ? List<Product>.from(json['data'].map((x) => Product.fromJson(x)))
          : [],
    );
  }
}

class Product {
  final num? sold; // Use `num` to handle both int and double
  final List<String>? images;
  final List<Subcategory>? subcategory;
  final int? ratingsQuantity;
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final int? quantity;
  final int? price;
  final int? priceAfterDiscount; // Make it nullable
  final String? imageCover;
  final Category? category;
  final Brand? brand;
  final num? ratingsAverage; // Use `num` for flexibility
  final String? createdAt;
  final String? updatedAt;

  Product({
    this.sold,
    this.images,
    this.subcategory,
    this.ratingsQuantity,
    this.id,
    this.title,
    this.slug,
    this.description,
    this.quantity,
    this.price,
    this.priceAfterDiscount,
    this.imageCover,
    this.category,
    this.brand,
    this.ratingsAverage,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      // Safely parse `sold`. `num.tryParse` is great for this.
      sold: json['sold'] != null ? num.tryParse(json['sold'].toString()) : 0,

      images: json['images'] != null && json['images'] is List
          ? List<String>.from(json['images'].map((x) => x.toString()))
          : [],

      subcategory: json['subcategory'] != null && json['subcategory'] is List
          ? List<Subcategory>.from(
          json['subcategory'].map((x) => Subcategory.fromJson(x)))
          : [],

      ratingsQuantity: json['ratingsQuantity'],
      id: json['id'] ?? json['_id'],
      // Handle both 'id' and '_id'
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      quantity: json['quantity'],
      price: json['price'],

      // Safely parse `priceAfterDiscount` by checking for null
      priceAfterDiscount: json['priceAfterDiscount'],

      imageCover: json['imageCover'],

      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
      brand: json['brand'] != null ? Brand.fromJson(json['brand']) : null,

      // Safely parse `ratingsAverage`
      ratingsAverage: json['ratingsAverage'] != null ? num.tryParse(
          json['ratingsAverage'].toString()) : 0.0,

      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  toJson() {}
}

// Sub-models for nested JSON objects (Brand, Category, etc.)

class Brand {
  final String? id;
  final String? name;

  // Add other fields if you need them

  Brand({this.id, this.name});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class Category {
  final String? id;
  final String? name;

  Category({this.id, this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class Subcategory {
  final String? id;
  final String? name;

  Subcategory({this.id, this.name});

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json["_id"],
      name: json["name"],
    );
  }
}

class Metadata {
  final int? currentPage;
  final int? numberOfPages;

  Metadata({this.currentPage, this.numberOfPages});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      currentPage: json['currentPage'],
      numberOfPages: json['numberOfPages'],
    );
  }
}
