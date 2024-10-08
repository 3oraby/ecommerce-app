import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/show_error_with_internet_dialog.dart';
import 'package:e_commerce_app/core/helpers/functions/show_custom_snack_bar.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_rounded_icon.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/orders/data/models/order_items_model.dart';
import 'package:e_commerce_app/features/orders/presentation/cubit/order_cubit.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/custom_product_details_in_orders.dart';
import 'package:e_commerce_app/features/reviews/data/models/check_user_review_for_product_model.dart';
import 'package:e_commerce_app/features/reviews/data/models/make_review_request_model.dart';
import 'package:e_commerce_app/features/reviews/presentation/cubit/review_cubit.dart';
import 'package:e_commerce_app/features/reviews/presentation/widgets/un_reviewed_product_body.dart';
import 'package:e_commerce_app/features/user/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MakeNewReviewLoadedBody extends StatefulWidget {
  const MakeNewReviewLoadedBody({
    super.key,
    required this.checkUserReviewForProductModel,
  });
  final CheckUserReviewForProductModel checkUserReviewForProductModel;

  @override
  State<MakeNewReviewLoadedBody> createState() =>
      _MakeNewReviewLoadedBodyState();
}

class _MakeNewReviewLoadedBodyState extends State<MakeNewReviewLoadedBody> {
  OrderItemModel? orderItem;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  MakeReviewRequestModel makeReviewRequestModel = MakeReviewRequestModel();
  bool? showMakingReviewBody;
  bool? showFeedbackRating;
  UserCubit? userCubit;
  bool isOperationLoading = false;
  bool showSuccessMakingReview = false;

  @override
  void initState() {
    super.initState();
    orderItem = BlocProvider.of<OrderCubit>(context).getSelectedOrderItemModel;
    showMakingReviewBody = !widget.checkUserReviewForProductModel.hasReviewed;
    showFeedbackRating = widget.checkUserReviewForProductModel.hasReviewed;
    userCubit = BlocProvider.of<UserCubit>(context);
  }

  Future<void> submitReview(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final ReviewCubit reviewCubit = BlocProvider.of<ReviewCubit>(context);
      if (widget.checkUserReviewForProductModel.hasReviewed) {
        reviewCubit.updateReview(
          productId: orderItem!.product.id,
          jsonData: makeReviewRequestModel.toJson(),
          reviewId:
              widget.checkUserReviewForProductModel.productReviewModel!.id,
        );
      } else {
        reviewCubit.createReview(
          productId: orderItem!.product.id,
          jsonData: makeReviewRequestModel.toJson(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Visibility(
                  visible: showSuccessMakingReview,
                  child: const SuccessMakingReviewWidget(),
                ),
                const VerticalGap(4),
                CustomProductDetailsInOrders(
                  orderItem: orderItem!,
                  showQuantity: false,
                  productReviewModel:
                      widget.checkUserReviewForProductModel.productReviewModel,
                  onEditReviewTap: () {
                    setState(() {
                      showMakingReviewBody = true;
                      showFeedbackRating = false;
                    });
                  },
                ),
                const VerticalGap(4),
                Visibility(
                  visible: showMakingReviewBody!,
                  child: UnReviewedProductBody(
                    makeReviewRequestModel: makeReviewRequestModel,
                    onRateChange: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const VerticalGap(24),
        Visibility(
          visible: showMakingReviewBody!,
          child: BlocListener<ReviewCubit, ReviewState>(
            listener: (context, state) {
              if (state is CreateReviewNoNetworkErrorState ||
                  state is UpdateReviewNoNetworkErrorState) {
                showErrorWithInternetDialog(context);
              } else if (state is CreateReviewLoadingState ||
                  state is UpdateReviewLoadingState ||
                  state is CheckUserReviewForProductLoadingState) {
                setState(() {
                  isOperationLoading = true;
                });
              } else if (state is CreateReviewErrorState ||
                  state is UpdateReviewErrorState ||
                  state is CheckUserReviewForProductErrorState) {
                setState(() {
                  isOperationLoading = false;
                });
                showCustomSnackBar(context, (state as dynamic).message);
              } else if (state is CreateReviewLoadedState ||
                  state is UpdateReviewLoadedState) {
                setState(() {
                  isOperationLoading = false;
                  showSuccessMakingReview = true;
                  showMakingReviewBody = false;
                  makeReviewRequestModel = MakeReviewRequestModel();
                });
              } else if (state is CheckUserReviewForProductLoadedState) {
                setState(() {
                  isOperationLoading = false;
                });
              }
            },
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.14,
              padding: LocalConstants.internalPadding,
              child: Center(
                child: CustomTriggerButton(
                  description: widget.checkUserReviewForProductModel.hasReviewed
                      ? "UPDATE REVIEW"
                      : "SUBMIT REVIEW",
                  descriptionSize: 22,
                  buttonHeight: 55,
                  backgroundColor:
                      makeReviewRequestModel.isRateNull() || isOperationLoading
                          ? ThemeColors.unEnabledButtonsColor
                          : ThemeColors.primaryColor,
                  isEnabled: !makeReviewRequestModel.isRateNull(),
                  onPressed: () async {
                    await submitReview(context);
                  },
                  child: isOperationLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: ThemeColors.primaryColor,
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SuccessMakingReviewWidget extends StatelessWidget {
  const SuccessMakingReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VerticalGap(4),
        Container(
          color: Colors.white,
          padding: LocalConstants.internalPadding,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRoundedIcon(
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                ),
              ),
              VerticalGap(16),
              Text(
                "Thanks for your feedback",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.mainLabelsColor,
                ),
              ),
              VerticalGap(16),
              Text(
                "Thank you for sharing your experience!",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              VerticalGap(4),
              Text(
                "It helps us to serve you better.",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        const VerticalGap(16),
      ],
    );
  }
}
