part of 'review_cubit.dart';

abstract class ReviewState {}

final class ReviewInitial extends ReviewState {}

final class GetReviewsLoadingState extends ReviewState {}

final class GetReviewsLoadedState extends ReviewState {
  final List<ProductReviewModel> productReviews;
  GetReviewsLoadedState({required this.productReviews});
}

final class GetReviewsErrorState extends ReviewState {
  final String message;
  GetReviewsErrorState({required this.message});
}
