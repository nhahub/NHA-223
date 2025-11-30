class CategoriesResponse {
  final int results;
  final Metadata metadata;
  final List<CategoryItem> data;

  CategoriesResponse({
    required this.results,
    required this.metadata,
    required this.data,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CategoriesResponse(
      results: json['results'],
      metadata: Metadata.fromJson(json['metadata']),
      data: List<CategoryItem>.from(
        json['data'].map((item) => CategoryItem.fromJson(item)),
      ),
    );
  }
}

class Metadata {
  final int currentPage;
  final int numberOfPages;
  final int limit;

  Metadata({
    required this.currentPage,
    required this.numberOfPages,
    required this.limit,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      currentPage: json['currentPage'],
      numberOfPages: json['numberOfPages'],
      limit: json['limit'],
    );
  }
}

class CategoryItem {
  final String id;
  final String name;
  final String slug;
  final String image;
  final String createdAt;
  final String updatedAt;

  CategoryItem({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
