
import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';

class UpdateCartItemService {
  static Future<bool> updateCartItem({
    required int cartId,
    required int newQuantity,
  }) async {
    try {
      Response response = await Api().patch(
        url:
            "${ApiConstants.baseUrl}${ApiConstants.updateCartItemEndPoint}$cartId",
        jsonData: {
          "quantity": newQuantity,
        },
      );
      if (response.data["status"] == "success") {
        return true;
      }
      return false;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
