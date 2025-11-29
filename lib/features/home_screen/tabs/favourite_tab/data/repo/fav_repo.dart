import 'package:final_depi_project/core/api_constant.dart';
import 'package:final_depi_project/core/dio_helper.dart';
import 'package:final_depi_project/features/home_screen/tabs/favourite_tab/data/model/addfav_response.dart';
import 'package:final_depi_project/features/home_screen/tabs/favourite_tab/data/model/allfav_response.dart';
import 'package:final_depi_project/features/home_screen/tabs/favourite_tab/data/model/removefav_response.dart';

class FavRepo {
  Future<AllFavResponse> getAllFavorites(String token) async {
    try {
      final response = await DioHelper.get(
        ApiConstant.wishlistEndPoint,
        token: token,
      );
      return AllFavResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load favorites: $e');
    }
  }

  Future<AddFavResponse> addToFavorites(String productId, String token) async {
    try {
      final response = await DioHelper.post(
        ApiConstant.wishlistEndPoint,
        data: {'productId': productId},
        token: token,
      );
      return AddFavResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to add to favorites: $e');
    }
  }

  Future<RemoveFavResponse> removeFromFavorites(
    String productId,
    String token,
  ) async {
    try {
      // The productId should be in the URL path, not as query parameter
      final response = await DioHelper.delete(
        '${ApiConstant.wishlistEndPoint}/$productId', // Append productId to URL
        token: token,
      );
      return RemoveFavResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to remove from favorites: $e');
    }
  }
}
