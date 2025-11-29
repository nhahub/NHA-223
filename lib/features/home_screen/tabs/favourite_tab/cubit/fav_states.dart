part of 'fav_cubit.dart';

@immutable
abstract class FavState {}

class FavInitial extends FavState {}

class FavLoading extends FavState {}

class FavSuccess extends FavState {
  final String message;
  FavSuccess(this.message);
}

class FavError extends FavState {
  final String error;
  FavError(this.error);
}

class AllFavLoaded extends FavState {
  final List<WishlistProduct> favorites;
  AllFavLoaded(this.favorites);
}

class FavProductToggled extends FavState {
  final bool isFavorite;
  final String productId;
  FavProductToggled(this.isFavorite, this.productId);
}
