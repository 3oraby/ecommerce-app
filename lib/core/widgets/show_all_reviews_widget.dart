
import 'package:e_commerce_app/core/helpers/functions/get_time_ago.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_product_details_widgets/custom_rating_bar_indicator.dart';
import 'package:e_commerce_app/features/reviews/data/models/product_review_model.dart';
import 'package:flutter/material.dart';

class ShowAllReviews extends StatelessWidget {
  const ShowAllReviews({
    super.key,
    required this.productReviews,
    this.showTotalReviews = true,
    this.enablePadding = true,
  });

  final List<ProductReviewModel> productReviews;
  final bool showTotalReviews;
  final bool enablePadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: enablePadding
          ? const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: showTotalReviews,
            child: Text(
              "${productReviews.length} Reviews",
              style: const TextStyle(
                color: ThemeColors.mainLabelsColor,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const VerticalGap(8),
          Visibility(
            visible: showTotalReviews,
            child: const Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
          ),
          const VerticalGap(8),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: showTotalReviews
                ? productReviews.length
                : productReviews.length < 3
                    ? productReviews.length
                    : 3,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.grey,
              thickness: 0.3,
              height: 36,
            ),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomRatingBarIndicator(
                        averageRating: productReviews[index].rate.toString(),
                        itemSize: 30,
                      ),
                      Text(
                        getTimeAgo(productReviews[index].date),
                        style: const TextStyle(
                          color: ThemeColors.subLabelsColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const VerticalGap(16),
                  Text(
                    productReviews[index].description,
                    style: const TextStyle(
                      color: ThemeColors.mainLabelsColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
