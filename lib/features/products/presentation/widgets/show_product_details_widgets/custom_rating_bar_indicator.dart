
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingBarIndicator extends StatelessWidget {
  const CustomRatingBarIndicator({
    super.key,
    required this.averageRating,
    this.itemSize = 40,
    this.itemCount = 5,
    this.icon =  const Icon(
        Icons.star,
        color: ThemeColors.successfullyDoneColor,
      ),
  });

  final String averageRating;
  final double itemSize;
  final int itemCount;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: double.parse(averageRating),
      itemCount: itemCount,
      itemSize: itemSize,
      itemBuilder: (context, index) => icon
    );
  }
}
