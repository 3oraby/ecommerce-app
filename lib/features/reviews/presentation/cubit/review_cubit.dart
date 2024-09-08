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

      if (getProductReviewsResponseModel.status) {
        emit(GetReviewsLoadedState(
            productReviews: getProductReviewsResponseModel.productReviews!));
      } else {
        emit(GetReviewsErrorState(
            message: getProductReviewsResponseModel.message!));
      }
    } catch (e) {
      emit(GetReviewsErrorState(message: e.toString()));
    }
  }
}
