import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';

class DeleteReviewService {
  Future<bool> deleteReview({
    required int productId,
    required int reviewId,
  }) async {
    try {
      Response response = await Api().patch(
        url:
            "${ApiConstants.baseUrl}${ApiConstants.deleteReviewEndPoint(productId, reviewId)}",
      );
      if (response.data["status"] == "success") {
        return true;
      } else {
        throw Exception(response.data["message"]);
      }
    } catch (e) {
      throw Exception(
          "there was an error in the server now ,please try again later");
    }
  }
}
