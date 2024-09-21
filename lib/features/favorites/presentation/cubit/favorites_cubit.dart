import 'dart:developer';
import 'package:e_commerce_app/features/favorites/data/models/get_favorites_response_model.dart';
import 'package:e_commerce_app/features/favorites/data/repositories/favorites_repository.dart';
import 'package:e_commerce_app/features/favorites/presentation/cubit/favorites_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository favoritesRepository;

  FavoritesCubit({required this.favoritesRepository})
      : super(FavoritesInitial());

  Future<void> getFavorites() async {
    emit(FavoritesLoading());
    log('Fetching favorites...');
    try {
      final GetFavoritesResponseModel getFavoritesResponseModel =
          await favoritesRepository.getFavorites();
      if (getFavoritesResponseModel.favoriteProducts!.isEmpty) {
        emit(FavoritesEmpty());
      } else {
        emit(FavoritesLoaded(favorites: getFavoritesResponseModel));
      }
      log('Favorites fetched successfully');
    } catch (e) {
      emit(FavoritesError(
        message: 'Failed to fetch favorites: $e',
      ));
      log('Error fetching favorites: $e');
    }
  }

  Future<void> toggleFavorite({
    required int productId,
    bool shouldRefresh = false,
  }) async {

    emit(ToggleFavoritesLoadingState(productId: productId));
    try {
      final success = await favoritesRepository.toggleFavorite(productId);
      if (success && shouldRefresh) {
        log('Favorite toggled successfully');
        emit(ToggleFavoritesLoadedState());
        await getFavorites();
      } else if (success) {
        emit(ToggleFavoritesLoadedState());
      } else {
        emit(ToggleFavoritesErrorState(
            message: 'Failed to update favorite status'));
        log('Failed to update favorite status');
      }
    } catch (e) {
      emit(ToggleFavoritesErrorState(message: 'Error toggling favorite: $e'));
      log('Error toggling favorite: $e');
    }
  }
}
