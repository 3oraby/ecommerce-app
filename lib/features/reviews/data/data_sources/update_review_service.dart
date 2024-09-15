import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';
import 'package:e_commerce_app/features/reviews/data/models/product_review_model.dart';

class UpdateReviewService {
  Future<ProductReviewModel> updateReview({
    required int productId,
    required int reviewId,
    required Map<String, dynamic> jsonData,
  }) async {
    try {
      Response response = await Api().patch(
        url:
            "${ApiConstants.baseUrl}${ApiConstants.updateReviewEndPoint(productId, reviewId)}",
        jsonData: jsonData,
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
