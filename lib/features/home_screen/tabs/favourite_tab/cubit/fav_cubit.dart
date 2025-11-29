import 'dart:developer';

import 'package:final_depi_project/features/home_screen/tabs/favourite_tab/data/model/allfav_response.dart';
import 'package:final_depi_project/features/home_screen/tabs/favourite_tab/data/repo/fav_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fav_states.dart';

class FavCubit extends Cubit<FavState> {
  final FavRepo _favRepo;

  FavCubit(this._favRepo) : super(FavInitial());

  static FavCubit get(context) => BlocProvider.of(context);

  List<WishlistProduct> favorites = [];

  Future<void> getAllFavorites(String token) async {
    emit(FavLoading());
    try {
      final response = await _favRepo.getAllFavorites(token);
      favorites = response.data;
      emit(AllFavLoaded(favorites));
    } catch (e) {
      log('Error getting favorites: $e');
      emit(FavError(e.toString()));
    }
  }

  Future<void> addToFavorites(String productId, String token) async {
    try {
      final response = await _favRepo.addToFavorites(productId, token);
      await getAllFavorites(token);
      emit(FavSuccess(response.message));
    } catch (e) {
      log('Error adding to favorites: $e');
      emit(FavError(e.toString()));
    }
  }

  Future<void> removeFromFavorites(String productId, String token) async {
    final currentFavorites = List<WishlistProduct>.from(favorites);

    try {
      favorites.removeWhere((product) => product.id == productId);
      emit(AllFavLoaded(List.from(favorites)));
      final response = await _favRepo.removeFromFavorites(productId, token);
      emit(FavSuccess(response.message));
    } catch (e) {
      favorites = currentFavorites;
      emit(AllFavLoaded(favorites));
      log('Error removing from favorites: $e');
      emit(FavError(e.toString()));
    }
  }

  bool isProductInFavorites(String productId) {
    return favorites.any((product) => product.id == productId);
  }

  void toggleFavorite(String productId, String token) {
    if (isProductInFavorites(productId)) {
      removeFromFavorites(productId, token);
    } else {
      addToFavorites(productId, token);
    }
  }
}
