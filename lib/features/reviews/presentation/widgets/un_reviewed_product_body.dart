import 'dart:developer';

import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_text_form_field.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/reviews/constants/review_feature_constants.dart';
import 'package:e_commerce_app/features/reviews/data/models/make_review_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UnReviewedProductBody extends StatefulWidget {
  const UnReviewedProductBody({
    super.key,
    required this.makeReviewRequestModel,
    required this.onRateChange,
  });
  final MakeReviewRequestModel makeReviewRequestModel;
  final Function(double value) onRateChange;
  @override
  State<UnReviewedProductBody> createState() => _UnReviewedProductBodyState();
}

class _UnReviewedProductBodyState extends State<UnReviewedProductBody> {
  int rateSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: LocalConstants.internalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalGap(4),
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
                            .rateReviewStates[rateSelected - 1].starColor,
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
                  widget.makeReviewRequestModel.rate = value.toInt();
                  widget.onRateChange(value);
                },
              ),
              const HorizontalGap(8),
              if (rateSelected != 0)
                Text(
                  ReviewFeatureConstants
                      .rateReviewStates[rateSelected - 1].rateState,
                  style: TextStyle(
                    color: ReviewFeatureConstants
                        .rateReviewStates[rateSelected - 1].starColor,
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
            hintText: ReviewFeatureConstants.labelTextForMakingReview,
            borderWidth: 0.3,
            fillColor: Colors.white,
            maxLines: 5,
            hintStyle: TextStyle(color: Colors.grey[400]),
            onChanged: (value) {
              widget.makeReviewRequestModel.reviewState = value;
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
    );
  }
}
