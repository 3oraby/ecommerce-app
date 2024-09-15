import 'package:e_commerce_app/features/reviews/data/models/check_user_review_for_product_model.dart';
import 'package:e_commerce_app/features/reviews/data/models/get_product_reviews_response_model.dart';
import 'package:e_commerce_app/features/reviews/data/models/product_review_model.dart';

abstract class ReviewRepository {
  Future<GetProductReviewsResponseModel> getProductReviews({
    required int productId,
  });

  Future<ProductReviewModel> getReview({
    required int productId,
    required int reviewId,
  });

  Future<bool> deleteReview({
    required int productId,
    required int reviewId,
  });

  Future<ProductReviewModel> updateReview({
    required int productId,
    required int reviewId,
    required Map<String,dynamic> jsonData,
  });

  Future<ProductReviewModel> createReview({
    required int productId,
    required Map<String ,dynamic> jsonData,
  });

  Future<String?> getProductAverageRating({
    required int productId,
  });

  Future<CheckUserReviewForProductModel> checkUserReviewForProduct({
    required int productId,
    required int userId,
  });
}
