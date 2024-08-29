import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';

class CheckProductInCartService {
  Future<bool> checkProductInCart({
    required int productId,
  }) async {
    try {
      Response response = await Api().get(
        url:
            "${ApiConstants.baseUrl}${ApiConstants.checkProductInCartEndPoint}$productId",
      );
      if (response.data["status"] == "success") {
        return response.data["data"];
      } else {
        throw Exception(response.data["message"]);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
