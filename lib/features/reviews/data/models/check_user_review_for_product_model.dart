import 'package:e_commerce_app/features/reviews/data/models/product_review_model.dart';

class CheckUserReviewForProductModel {
  final bool hasReviewed;
  final ProductReviewModel? productReviewModel;

  CheckUserReviewForProductModel({
    required this.hasReviewed,
    this.productReviewModel,
  });

  factory CheckUserReviewForProductModel.fromJson(Map<String, dynamic> json) {
    return CheckUserReviewForProductModel(
      hasReviewed: json["data"]["hasReviewed"],
      productReviewModel: json["data"]["hasReviewed"]
          ? ProductReviewModel.fromJson(json["data"]["review"])
          : null,
    );
  }
}
