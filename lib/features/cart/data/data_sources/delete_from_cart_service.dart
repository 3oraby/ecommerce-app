import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';
import 'package:e_commerce_app/features/cart/data/models/delete_from_cart_response_model.dart';

class DeleteFromCartService {
  Future<DeleteFromCartResponseModel> deleteFromCart({
    required int cartItemId,
  }) async {
    try {
      Response response = await Api().post(
        url:
            "${ApiConstants.baseUrl}${ApiConstants.deleteFromCartEndPoint}$cartItemId",
      );
      return DeleteFromCartResponseModel.fromJson(json: response.data);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
