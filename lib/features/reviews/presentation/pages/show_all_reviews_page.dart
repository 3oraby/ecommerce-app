import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/reviews/presentation/cubit/review_cubit.dart';
import 'package:e_commerce_app/features/reviews/presentation/widgets/show_all_reviews_loaded_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowAllReviewsPage extends StatelessWidget {
  const ShowAllReviewsPage({super.key});
  static const String id = "kShowAllReviewsPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundBodiesColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Text(
          "Reviews",
          style: TextStyles.aDLaMDisplayBlackBold26,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ReviewCubit, ReviewState>(
        builder: (context, state) {
          if (state is GetReviewsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetReviewsErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is GetReviewsLoadedState) {
            return ShowAllReviewsLoadedBody(
              averageRating: state.averageRating,
              productReviews: state.productReviews,
            );
          } else {
            return const Center(
              child: Text("there is no reviews for this product"),
            );
          }
        },
      ),
    );
  }
}
