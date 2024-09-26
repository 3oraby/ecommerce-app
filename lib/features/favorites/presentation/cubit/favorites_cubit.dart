import 'dart:developer';
import 'package:e_commerce_app/core/helpers/functions/check_connection_with_internet.dart';
import 'package:e_commerce_app/features/favorites/data/models/get_favorites_response_model.dart';
import 'package:e_commerce_app/features/favorites/data/repositories/favorites_repository.dart';
import 'package:e_commerce_app/features/favorites/presentation/cubit/favorites_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository favoritesRepository;

  FavoritesCubit({required this.favoritesRepository})
      : super(FavoritesInitial());

  List<int> _productsWillMoveToFavorites = [];
  List<int> get getProductWillMoveToFavorites => _productsWillMoveToFavorites;

  Future<void> getFavorites() async {
    if (!await checkConnectionWithInternet()) {
      emit(FavoritesNoInternetConnectionState());
      return;
    }
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

  Future<bool> toggleFavorite({
    required int productId,
    bool shouldRefresh = false,
  }) async {
    if (!await checkConnectionWithInternet()) {
      emit(ToggleFavoritesNoInternetConnectionState(productId: productId));
      return false;
    }
    emit(ToggleFavoritesLoadingState(productId: productId));
    _productsWillMoveToFavorites.add(productId);
    try {
      final success = await favoritesRepository.toggleFavorite(productId);
      if (success) {
        log('Favorite toggled successfully');
        emit(ToggleFavoritesLoadedState());
        _productsWillMoveToFavorites.remove(productId);

        if (shouldRefresh) {
          await getFavorites();
        }
        return true;
      } else {
        emit(ToggleFavoritesErrorState(
            message: 'Failed to update favorite status'));
        log('Failed to update favorite status');
        _productsWillMoveToFavorites.remove(productId);

        return false;
      }
    } catch (e) {
      emit(ToggleFavoritesErrorState(message: 'Error toggling favorite: $e'));
      log('Error toggling favorite: $e');
      _productsWillMoveToFavorites.remove(productId);

      return false;
    }
  }
}
