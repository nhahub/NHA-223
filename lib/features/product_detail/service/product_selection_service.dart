
import '../../../core/shared_prefrences.dart';

class ProductSelectionService {
  static const String _selectedSizeKey = 'selected_size_';
  static const String _selectedColorKey = 'selected_color_';

  static Future<void> saveProductSelection({
    required String productId,
    String? selectedSize,
    String? selectedColor,
  }) async {
    if (selectedSize != null) {
      await AppSharedPreferences.setString('$_selectedSizeKey$productId', selectedSize);
    } else {
      await AppSharedPreferences.remove('$_selectedSizeKey$productId');
    }

    if (selectedColor != null) {
      await AppSharedPreferences.setString('$_selectedColorKey$productId', selectedColor);
    } else {
      await AppSharedPreferences.remove('$_selectedColorKey$productId');
    }
  }

  static Future<Map<String, String?>> loadProductSelection(String productId) async {
    final selectedSize = AppSharedPreferences.getString('$_selectedSizeKey$productId');
    final selectedColor = AppSharedPreferences.getString('$_selectedColorKey$productId');

    return {
      'size': selectedSize,
      'color': selectedColor,
    };
  }

  static Future<void> deleteProductSelection(String productId) async {
    await AppSharedPreferences.remove('$_selectedSizeKey$productId');
    await AppSharedPreferences.remove('$_selectedColorKey$productId');
  }
}