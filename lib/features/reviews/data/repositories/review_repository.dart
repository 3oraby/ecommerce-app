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

  Future<bool> updateReview({
    required int productId,
    required int reviewId,
  });

  Future<ProductReviewModel> createReview({
    required int productId,
  });

  Future<String> getProductAverageRating({
    required int productId,
  });
}
