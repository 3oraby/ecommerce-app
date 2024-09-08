
import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';

class GetProductAverageRatingService {
  Future<String> getProductAverageRating({
    required int productId,
  }) async {
    try {
      Response response = await Api().get(
        url:
            "${ApiConstants.baseUrl}${ApiConstants.getProductAverageRatingEndPoint(productId)}",
      );
      if (response.data["status"] == "success") {
        return response.data["data"][0]["averageRating"];
      } else {
        throw Exception(response.data["message"]);
      }
    } catch (e) {
      throw Exception(
          "there was an error in the server now ,please try again later");
    }
  }
}
