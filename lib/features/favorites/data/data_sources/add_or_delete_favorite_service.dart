import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';

class AddOrDeleteFavoritesService {
  static Future<bool> addOrDeleteFavorites({
    required int productId,
  }) async {
    try {
      Response response = await Api().post(
        url:
            "${ApiConstants.baseUrl}${ApiConstants.addOrDeleteFavoritesEndPoint}$productId",
      );
      if (response.data["status"] == "success"){
        return true;
      }else{
        return false;
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
