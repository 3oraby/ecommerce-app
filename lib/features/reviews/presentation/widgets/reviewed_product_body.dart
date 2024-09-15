import 'package:e_commerce_app/features/reviews/data/models/product_review_model.dart';
import 'package:flutter/material.dart';

class ReviewedProductBody extends StatefulWidget {
  const ReviewedProductBody({
    super.key,
    required this.productReviewModel,
  });
  final ProductReviewModel productReviewModel;

  @override
  State<ReviewedProductBody> createState() => _ReviewedProductBodyState();
}

class _ReviewedProductBodyState extends State<ReviewedProductBody> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
