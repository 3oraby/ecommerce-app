import 'package:e_commerce_app/features/reviews/data/data_sources/check_user_review_for_product_service.dart';
import 'package:e_commerce_app/features/reviews/data/data_sources/create_review_service.dart';
import 'package:e_commerce_app/features/reviews/data/data_sources/delete_review_service.dart';
import 'package:e_commerce_app/features/reviews/data/data_sources/get_product_average_rating_service.dart';
import 'package:e_commerce_app/features/reviews/data/data_sources/get_product_reviews_service.dart';
import 'package:e_commerce_app/features/reviews/data/data_sources/get_review_service.dart';
import 'package:e_commerce_app/features/reviews/data/data_sources/update_review_service.dart';
import 'package:e_commerce_app/features/reviews/data/models/check_user_review_for_product_model.dart';
import 'package:e_commerce_app/features/reviews/data/models/get_product_reviews_response_model.dart';
import 'package:e_commerce_app/features/reviews/data/models/product_review_model.dart';
import 'package:e_commerce_app/features/reviews/data/repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  ReviewRepositoryImpl({
    required this.getProductReviewsService,
    required this.getReviewService,
    required this.deleteReviewService,
    required this.updateReviewService,
    required this.createReviewService,
    required this.getProductAverageRatingService,
    required this.checkUserReviewForProductService,
  });

  final GetProductReviewsService getProductReviewsService;
  final GetReviewService getReviewService;
  final DeleteReviewService deleteReviewService;
  final UpdateReviewService updateReviewService;
  final CreateReviewService createReviewService;
  final GetProductAverageRatingService getProductAverageRatingService;
  final CheckUserReviewForProductService checkUserReviewForProductService;

  @override
  Future<GetProductReviewsResponseModel> getProductReviews(
      {required int productId}) async {
    return await getProductReviewsService.getProductReviews(
        productId: productId);
  }

  @override
  Future<ProductReviewModel> getReview(
      {required int productId, required int reviewId}) async {
    return await getReviewService.getReview(
        productId: productId, reviewId: reviewId);
  }

  @override
  Future<bool> deleteReview(
      {required int productId, required int reviewId}) async {
    return await deleteReviewService.deleteReview(
        productId: productId, reviewId: reviewId);
  }

  @override
  Future<ProductReviewModel> updateReview({
    required int productId,
    required int reviewId,
    required Map<String, dynamic> jsonData,
  }) async {
    return await updateReviewService.updateReview(
      productId: productId,
      reviewId: reviewId,
      jsonData: jsonData,
    );
  }

  @override
  Future<ProductReviewModel> createReview(
      {required int productId, required Map<String, dynamic> jsonData}) async {
    return await createReviewService.createReview(
      productId: productId,
      jsonData: jsonData,
    );
  }

  @override
  Future<String?> getProductAverageRating({required int productId}) async {
    return await getProductAverageRatingService.getProductAverageRating(
        productId: productId);
  }

  @override
  Future<CheckUserReviewForProductModel> checkUserReviewForProduct({
    required int productId,
    required int userId,
  }) async {
    return await checkUserReviewForProductService.checkUserReviewForProduct(
        productId: productId, userId: userId);
  }
}
