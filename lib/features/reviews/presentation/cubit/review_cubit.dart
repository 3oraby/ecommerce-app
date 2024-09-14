import 'package:e_commerce_app/features/reviews/data/models/check_user_review_for_product_model.dart';
import 'package:e_commerce_app/features/reviews/data/models/get_product_reviews_response_model.dart';
import 'package:e_commerce_app/features/reviews/data/models/product_review_model.dart';
import 'package:e_commerce_app/features/reviews/data/repositories/review_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit({required this.reviewRepository}) : super(ReviewInitial());

  final ReviewRepository reviewRepository;

  Future<void> getProductReviews({required int productId}) async {
    emit(GetReviewsLoadingState());
    try {
      GetProductReviewsResponseModel getProductReviewsResponseModel =
          await reviewRepository.getProductReviews(productId: productId);

      String? averageRating =
          await reviewRepository.getProductAverageRating(productId: productId);

      if (getProductReviewsResponseModel.status) {
        emit(GetReviewsLoadedState(
          productReviews: getProductReviewsResponseModel.productReviews!,
          averageRating: averageRating,
        ));
      } else {
        emit(GetReviewsErrorState(
            message: getProductReviewsResponseModel.message!));
      }
    } catch (e) {
      emit(GetReviewsErrorState(message: e.toString()));
    }
  }

  Future<void> createReview(
      {required int productId, required Map<String, dynamic> jsonData}) async {
    emit(CreateReviewLoadingState());
    try {
      await reviewRepository.createReview(
          productId: productId, jsonData: jsonData);

      emit(CreateReviewLoadedState());
    } catch (e) {
      emit(GetReviewsErrorState(message: e.toString()));
    }
  }

  Future<void> checkUserReviewForProduct(
      {required int productId, required int userId}) async {
    emit(CheckUserReviewForProductLoadingState());
    try {
      CheckUserReviewForProductModel checkUserReviewForProductModel =
          await reviewRepository.checkUserReviewForProduct(
              productId: productId, userId: userId);

      emit(CheckUserReviewForProductLoadedState(
          checkUserReviewForProductModel: checkUserReviewForProductModel));
    } catch (e) {
      emit(CheckUserReviewForProductErrorState(message: e.toString()));
    }
  }
}
