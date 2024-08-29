import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/add_to_cart_service.dart';
import 'package:e_commerce_app/features/cart/data/models/add_to_cart_response_model.dart';

class UpdateCartItemService {
  Future<bool> updateCartItem({
    required int newQuantity,
    int? cartId,
    int? productId,
  }) async {
    try {
      if (productId != null) {
        AddToCartResponseModel addToCartResponseModel = await AddToCartService().addToCart(productId: productId);
        if (addToCartResponseModel.status){
          cartId = addToCartResponseModel.cartId;
        }else{
          throw Exception("can not add the product to cart");
        }
      }
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
