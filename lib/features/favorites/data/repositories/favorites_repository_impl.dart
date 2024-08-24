// favorites_repository_impl.dart
import 'package:e_commerce_app/features/favorites/data/data_sources/add_or_delete_favorite_service.dart';
import 'package:e_commerce_app/features/favorites/data/models/get_favorites_response_model.dart';
import 'favorites_repository.dart';
import 'package:e_commerce_app/features/favorites/data/data_sources/get_favorites_service.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final GetFavoritesService getFavoritesService;
  final AddOrDeleteFavoritesService addOrDeleteFavoritesService;

  FavoritesRepositoryImpl(
      this.getFavoritesService, this.addOrDeleteFavoritesService);

  @override
  Future<GetFavoritesResponseModel> getFavorites() async {
    return await getFavoritesService.getFavorites();
  }

  @override
  Future<bool> toggleFavorite(int productId) async {
    return await addOrDeleteFavoritesService.addOrDeleteFavorites(
      productId: productId,
    );
  }
}
