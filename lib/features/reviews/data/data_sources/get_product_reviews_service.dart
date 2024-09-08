import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';
import 'package:e_commerce_app/features/reviews/data/models/get_product_reviews_response_model.dart';

class GetProductReviewsService {
  Future<GetProductReviewsResponseModel> getProductReviews({
    required int productId,
  }) async {
    try {
      Response response = await Api().get(
        url:
            "${ApiConstants.baseUrl}${ApiConstants.getProductReviewsEndPoint(productId)}",
      );
      return GetProductReviewsResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception(
          "there was an error in the server now ,please try again later");
    }
  }
}
