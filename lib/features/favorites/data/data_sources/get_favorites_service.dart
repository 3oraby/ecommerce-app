import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';
import 'package:e_commerce_app/features/favorites/data/models/get_favorites_response_model.dart';

class GetFavoritesService {
  Future<GetFavoritesResponseModel> getFavorites() async {
    try {
      Response response = await Api().get(
        url: "${ApiConstants.baseUrl}${ApiConstants.getFavoritesEndPoint}",
      );
      return GetFavoritesResponseModel.fromJson(json: response.data);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
