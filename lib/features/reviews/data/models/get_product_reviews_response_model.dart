import 'package:e_commerce_app/core/models/error_model.dart';
import 'package:e_commerce_app/features/reviews/data/models/product_review_model.dart';

class GetProductReviewsResponseModel {
  final bool status;
  final List<ProductReviewModel>? productReviews;
  final ErrorModel? error;
  final String? message;

  GetProductReviewsResponseModel({
    required this.status,
    this.productReviews,
    this.error,
    this.message,
  });

  factory GetProductReviewsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] == "success") {
      List reviewsData = json["data"];
      return GetProductReviewsResponseModel(
        status: true,
        productReviews: reviewsData
            .map(
              (jsonReview) => ProductReviewModel.fromJson(jsonReview),
            )
            .toList(),
      );
    } else {
      return GetProductReviewsResponseModel(
        status: false,
        error: ErrorModel.fromJson(json['error']),
        message: json['message'],
      );
    }
  }
}
