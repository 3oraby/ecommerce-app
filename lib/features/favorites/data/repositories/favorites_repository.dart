import 'package:e_commerce_app/features/favorites/data/models/get_favorites_response_model.dart';

abstract class FavoritesRepository {
  Future<GetFavoritesResponseModel> getFavorites();
  Future<bool> toggleFavorite(int productId);
}
