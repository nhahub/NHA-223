import '../../../home_tab/data/model/get_all_product_response.dart';

class Product {
  final String? id;
  final String? title;
  final int? quantity;
  final String? imageCover;
  final Category? category;
  final Brand? brand;
  final double? ratingsAverage;
  final List<Subcategory>? subcategory;

  Product({
    this.id,
    this.title,
    this.quantity,
    this.imageCover,
    this.category,
    this.brand,
    this.ratingsAverage,
    this.subcategory,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? json['id'],
      title: json['title'],
      quantity: json['quantity'],
      imageCover: json['imageCover'],
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
      brand: json['brand'] != null ? Brand.fromJson(json['brand']) : null,
      ratingsAverage: json['ratingsAverage']?.toDouble(),
      subcategory: json['subcategory'] != null
          ? (json['subcategory'] as List).map((v) => Subcategory.fromJson(v)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['quantity'] = quantity;
    data['imageCover'] = imageCover;
    data['ratingsAverage'] = ratingsAverage;
    data['id'] = id;

    if (category != null) {
      data['category'] = category!;
    }

    if (brand != null) {
      data['brand'] = brand!;
    }

    if (subcategory != null) {
      data['subcategory'] = subcategory!.map((sub) {
        return {
          '_id': sub.id,
          'name': sub.name,

        };
      }).toList();
    }

    return data;
  }
}