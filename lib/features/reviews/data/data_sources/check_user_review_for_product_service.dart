import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';
import 'package:e_commerce_app/features/reviews/data/models/check_user_review_for_product_model.dart';

class CheckUserReviewForProductService {
  Future<CheckUserReviewForProductModel> checkUserReviewForProduct({
    required int productId,
    required int userId,
  }) async {
    try {
      Response response = await Api().get(
        url:
            "${ApiConstants.baseUrl}${ApiConstants.checkUserReviewForProductEndPoint(
          productId: productId,
          userId: userId,
        )}",
      );
      return CheckUserReviewForProductModel.fromJson(response.data);
    } catch (e) {
      throw Exception(
          "there was an error in the server now ,please try again later");
    }
  }
}
