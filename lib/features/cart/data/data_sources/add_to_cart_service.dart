import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';
import 'package:e_commerce_app/features/cart/data/models/add_to_cart_response_model.dart';

class AddToCartService {
  static Future<AddToCartResponseModel> addToCart({
    required int productId,
  }) async {
    try {
      Response response = await Api().post(
        url:
            "${ApiConstants.baseUrl}${ApiConstants.addToCartEndPoint}$productId",
      );
      return AddToCartResponseModel.fromJson(json: response.data);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
