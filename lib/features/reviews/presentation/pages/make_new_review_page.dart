import 'package:e_commerce_app/core/helpers/functions/show_snack_bar.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/reviews/presentation/cubit/review_cubit.dart';
import 'package:e_commerce_app/features/reviews/presentation/widgets/make_new_review_loaded_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class MakeNewReviewPage extends StatefulWidget {
  const MakeNewReviewPage({super.key});

  static const String id = "kMakeNewReviewPage";

  @override
  State<MakeNewReviewPage> createState() => _MakeNewReviewPageState();
}

class _MakeNewReviewPageState extends State<MakeNewReviewPage> {
  bool isPageLoading = false;
  bool showSuccessMakingReview = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isPageLoading,
      child: Scaffold(
        backgroundColor: ThemeColors.backgroundBodiesColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Product review",
            style: TextStyles.aDLaMDisplayBlackBold26,
          ),
        ),
        body: BlocConsumer<ReviewCubit, ReviewState>(
          listener: (context, state) {
            if (state is CreateReviewLoadingState ||
                state is UpdateReviewLoadingState ||
                state is CheckUserReviewForProductLoadingState) {
              setState(() {
                isPageLoading = true;
              });
            } else if (state is CreateReviewErrorState ||
                state is UpdateReviewErrorState ||
                state is CheckUserReviewForProductErrorState) {
              setState(() {
                isPageLoading = false;
              });
              showSnackBar(context, (state as dynamic).message);
            } else if (state is CreateReviewLoadedState ||
                state is UpdateReviewLoadedState) {
              setState(() {
                isPageLoading = false;
                showSuccessMakingReview = true;
              });
            } else {
              setState(() {
                isPageLoading = false;
              });
            }
          },
          builder: (context, state) {
            if (state is CheckUserReviewForProductLoadedState ||
                state is CreateReviewLoadedState ||
                state is UpdateReviewLoadedState) {
              return MakeNewReviewLoadedBody(
                checkUserReviewForProductModel:
                    (state as dynamic).checkUserReviewForProductModel,
                showSuccessMakingReview: showSuccessMakingReview,
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
