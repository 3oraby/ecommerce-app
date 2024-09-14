part of 'review_cubit.dart';

abstract class ReviewState {}

final class ReviewInitial extends ReviewState {}

final class GetReviewsLoadingState extends ReviewState {}

final class GetReviewsLoadedState extends ReviewState {
  final List<ProductReviewModel> productReviews;
  final String? averageRating;
  GetReviewsLoadedState({
    required this.productReviews,
    required this.averageRating,
  });
}

final class GetReviewsErrorState extends ReviewState {
  final String message;
  GetReviewsErrorState({required this.message});
}

final class CreateReviewLoadingState extends ReviewState {}

final class CreateReviewLoadedState extends ReviewState {}

final class CreateReviewErrorState extends ReviewState {
  final String message;
  CreateReviewErrorState({required this.message});
}

final class CheckUserReviewForProductLoadingState extends ReviewState {}

final class CheckUserReviewForProductErrorState extends ReviewState {
  final String message;
  CheckUserReviewForProductErrorState({required this.message});
}

final class CheckUserReviewForProductLoadedState extends ReviewState {
  final CheckUserReviewForProductModel checkUserReviewForProductModel;
  CheckUserReviewForProductLoadedState({required this.checkUserReviewForProductModel});
}
