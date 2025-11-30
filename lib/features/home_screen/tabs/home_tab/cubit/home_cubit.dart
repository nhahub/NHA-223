import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/home_repo/home_repo.dart';
import '../data/model/get_all_product_response.dart';
import '../peresentaion/widgets/category_widget.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;


  Map<String, List<Product>> productsByCategory = {};
  List<Product> mens=[];
  List<Product> allProducts=[];
  List<Product> women=[];
  List<Product> electronics =[];

  /// Static category names
  final List<String> categoriesNames = [
    "All",
    "Men's Fashion",
    "Women's Fashion",
    "Electronics",
  ];

  List<CategoryWidget> categoriesList = [];

  final Map<String, IconData> categoryIcons = {
    "All":Icons.category,
    "Men's Fashion": Icons.male,
    "Women's Fashion": Icons.female,
    "Electronics": Icons.electrical_services,
  };

  HomeCubit(this.homeRepository) : super(HomeInitial()) {
    _generateCategoryWidgets();
    fetchProducts();
  }

  void _generateCategoryWidgets() {
    categoriesList = categoriesNames.map((name) {
      return CategoryWidget(
        icon: categoryIcons[name] ?? Icons.category,
        label: name,
      );
    }).toList();
  }

  Future<void> getAllCategories() async {
    emit(GetCategoriesLoading());

    try {
      final categories = await homeRepository.getAllCategories();
      emit(GetCategoriesSuccess(categories));
    } catch (e) {
      emit(GetCategoriesError(e.toString()));
    }
  }

  Future<void> fetchProducts() async {
    emit(ProductsLoading());

    try {
      final response = await homeRepository.getProducts();

      productsByCategory = _separateProductsByCategory(response);
      allProducts=response.data??[];
      women=productsByCategory["Women's Fashion"]??[];
      mens=productsByCategory["Men's Fashion"]??[];
      electronics=productsByCategory["Electronics"]??[];

      print(productsByCategory);
      emit(ProductsLoaded(
        productsByCategory: productsByCategory,
      ));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  Map<String, List<Product>> _separateProductsByCategory(ProductResponse response) {
    final products = response.data ?? [];
    Map<String, List<Product>> categorizedProducts = {};

    for (var product in products) {
      final categoryName = product.category?.name ?? "Uncategorized";

      if (categorizedProducts.containsKey(categoryName)) {
        categorizedProducts[categoryName]!.add(product);
      } else {
        categorizedProducts[categoryName] = [product];
      }
    }

    return categorizedProducts;
  }
}
