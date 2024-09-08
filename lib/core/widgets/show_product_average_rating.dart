import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_product_details_widgets/custom_rating_bar_indicator.dart';
import 'package:flutter/material.dart';

class ShowAverageRating extends StatelessWidget {
  const ShowAverageRating({
    super.key,
    required this.averageRating,
    this.enablePadding = true,
  });

  final String averageRating;
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
          const Text(
            "Product Ratings & Reviews",
            style: TextStyle(
              color: ThemeColors.mainLabelsColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const VerticalGap(8),
          Text(
            double.parse(averageRating).toString(),
            style: const TextStyle(
              color: ThemeColors.mainLabelsColor,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const VerticalGap(8),
          CustomRatingBarIndicator(
            averageRating: averageRating,
            itemSize: 45,
          ),
        ],
      ),
    );
  }
}
