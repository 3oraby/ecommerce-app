// favorites_state.dart
import 'package:e_commerce_app/features/favorites/data/models/get_favorites_response_model.dart';

abstract class FavoritesState {
  const FavoritesState();
}

class FavoritesInitial extends FavoritesState {}

class RefreshFavoritesPageState extends FavoritesState {}

class FavoritesNoInternetConnectionState extends FavoritesState {}

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

class ToggleFavoritesLoadingState extends FavoritesState {
  final int productId;
  ToggleFavoritesLoadingState({required this.productId});
}

class ToggleFavoritesErrorState extends FavoritesState {
  final String message;
  ToggleFavoritesErrorState({required this.message});
}

class ToggleFavoritesLoadedState extends FavoritesState {
  final int productId;
  ToggleFavoritesLoadedState({required this.productId});

}

class ToggleFavoritesUnAuthState extends FavoritesState {
  final int productId;
  ToggleFavoritesUnAuthState({required this.productId});
}

class ToggleFavoritesNoInternetConnectionState extends FavoritesState {
  final int productId;
  ToggleFavoritesNoInternetConnectionState({required this.productId});
}
