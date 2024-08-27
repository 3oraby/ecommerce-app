import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';

class ShowCartItemService {
  Future<CartItemModel> showCartItem({
    required int cartItemId,
  }) async {
    try {
      Response response = await Api().get(
        url:
            "${ApiConstants.baseUrl}${ApiConstants.showCartItemEndPoint}$cartItemId",
      );
      if (response.data["status"] == "success") {
        return CartItemModel.fromJson(json: response.data["data"]);
      } else {
        throw Exception(response.data["message"]);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
