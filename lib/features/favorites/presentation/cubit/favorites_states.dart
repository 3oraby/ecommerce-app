// favorites_state.dart
import 'package:e_commerce_app/features/favorites/data/models/get_favorites_response_model.dart';

abstract class FavoritesState {
  const FavoritesState();
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesEmpty extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final GetFavoritesResponseModel favorites;

  const FavoritesLoaded({required this.favorites});
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError({required this.message});
}
