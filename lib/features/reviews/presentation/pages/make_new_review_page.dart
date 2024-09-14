import 'dart:developer';

import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/show_snack_bar.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_text_form_field.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/orders/data/models/order_items_model.dart';
import 'package:e_commerce_app/features/orders/presentation/cubit/order_cubit.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/custom_product_details_in_orders.dart';
import 'package:e_commerce_app/features/reviews/constants/review_feature_constants.dart';
import 'package:e_commerce_app/features/reviews/data/models/make_review_request_model.dart';
import 'package:e_commerce_app/features/reviews/presentation/cubit/review_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class MakeNewReviewPage extends StatefulWidget {
  const MakeNewReviewPage({super.key});

  static const String id = "kMakeNewReviewPage";

  @override
  State<MakeNewReviewPage> createState() => _MakeNewReviewPageState();
}

class _MakeNewReviewPageState extends State<MakeNewReviewPage> {
  MakeReviewRequestModel makeReviewRequestModel = MakeReviewRequestModel();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  OrderItemModel? orderItem;
  bool isPageLoading = false;
  int rateSelected = 0;

  @override
  void initState() {
    super.initState();
    orderItem = BlocProvider.of<OrderCubit>(context).getSelectedOrderItemModel;
  }

  void submitReview() async {
    if (formKey.currentState!.validate()) {
      await BlocProvider.of<ReviewCubit>(context).createReview(
        productId: orderItem!.product.id,
        jsonData: makeReviewRequestModel.toJson(),
      );
    }
  }

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
        body: BlocListener<ReviewCubit, ReviewState>(
          listener: (context, state) {
            if (state is CreateReviewLoadingState) {
              setState(() {
                isPageLoading = true;
              });
            } else if (state is CreateReviewErrorState) {
              setState(() {
                isPageLoading = false;
              });
              showSnackBar(context, state.message);
            } else {
              setState(() {
                isPageLoading = false;
              });
            }
          },
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const VerticalGap(4),
                    CustomProductDetailsInOrders(
                      orderItem: orderItem!,
                      showQuantity: false,
                    ),
                    const VerticalGap(4),
                    Container(
                      color: Colors.white,
                      padding: LocalConstants.internalPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "How do you rate this product?",
                            style: TextStyle(
                              color: ThemeColors.mainLabelsColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          const VerticalGap(8),
                          Row(
                            children: [
                              RatingBar(
                                allowHalfRating: false,
                                itemCount: 5,
                                initialRating: 0,
                                itemSize: 60,
                                ratingWidget: RatingWidget(
                                  full: Icon(
                                    Icons.star,
                                    color: rateSelected == 0
                                        ? Colors.grey[350]
                                        : ReviewFeatureConstants
                                            .rateReviewStates[rateSelected - 1]
                                            .starColor,
                                  ),
                                  half: const Icon(Icons.star),
                                  empty: Icon(
                                    Icons.star_border,
                                    color: Colors.grey[350],
                                  ),
                                ),
                                onRatingUpdate: (value) {
                                  setState(() {
                                    rateSelected = value.toInt();
                                  });
                                  makeReviewRequestModel.rate = value.toInt();
                                },
                              ),
                              const HorizontalGap(8),
                              if (rateSelected != 0)
                                Text(
                                  ReviewFeatureConstants
                                      .rateReviewStates[rateSelected - 1]
                                      .rateState,
                                  style: TextStyle(
                                    color: ReviewFeatureConstants
                                        .rateReviewStates[rateSelected - 1]
                                        .starColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                            ],
                          ),
                          const VerticalGap(24),
                          const Text(
                            "Write a product review",
                            style: TextStyle(
                              color: ThemeColors.mainLabelsColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          const VerticalGap(8),
                          CustomTextFormFieldWidget(
                            formKey: formKey,
                            hintText:
                                ReviewFeatureConstants.labelTextForMakingReview,
                            borderWidth: 0.3,
                            fillColor: Colors.white,
                            maxLines: 5,
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            onChanged: (value) {
                              makeReviewRequestModel.reviewState = value;
                              log(value);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Hold up, this field is required";
                              } else if (value.length < 3) {
                                return "Oops! this field needs to have at least 3 characters";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.14,
                padding: LocalConstants.internalPadding,
                child: Center(
                  child: CustomTriggerButton(
                    description: "SUBMIT REVIEW",
                    descriptionSize: 22,
                    buttonHeight: 55,
                    backgroundColor: makeReviewRequestModel.isRateNull()
                        ? ThemeColors.unEnabledButtonsColor
                        : ThemeColors.primaryColor,
                    isEnabled: !makeReviewRequestModel.isRateNull(),
                    onPressed: submitReview,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
