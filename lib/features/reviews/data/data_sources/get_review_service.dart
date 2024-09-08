import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';
import 'package:e_commerce_app/features/reviews/data/models/product_review_model.dart';

class GetReviewService {
  Future<ProductReviewModel> getReview({
    required int productId,
    required int reviewId,
  }) async {
    try {
      Response response = await Api().get(
        url:
            "${ApiConstants.baseUrl}${ApiConstants.getReviewDetailsEndPoint(productId, reviewId)}",
      );
      if (response.data["status"] == "success") {
        return ProductReviewModel.fromJson(response.data["data"]);
      } else {
        throw Exception(response.data["message"]);
      }
    } catch (e) {
      throw Exception(
          "there was an error in the server now ,please try again later");
    }
  }
}
