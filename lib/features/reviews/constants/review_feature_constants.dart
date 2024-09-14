import 'package:e_commerce_app/features/products/data/models/rate_review_states_model.dart';
import 'package:flutter/material.dart';

class ReviewFeatureConstants {
  static const List<RateReviewStatesModel> rateReviewStates = [
    RateReviewStatesModel(
      rate: 1,
      starColor: Color.fromARGB(255, 243, 108, 50),
      rateState: "Awful",
    ),
    RateReviewStatesModel(
      rate: 2,
      starColor: Color.fromARGB(255, 243, 108, 50),
      rateState: "Bad",
    ),
    RateReviewStatesModel(
      rate: 3,
      starColor: Color.fromARGB(255, 242, 171, 49),
      rateState: "Fair",
    ),
    RateReviewStatesModel(
      rate: 4,
      starColor: Color.fromARGB(255, 130, 173, 3),
      rateState: "Good",
    ),
    RateReviewStatesModel(
      rate: 5,
      starColor: Color.fromARGB(255, 56, 174, 4),
      rateState: "Superb",
    ),
  ];

  static const String labelTextForMakingReview =
      "What did you like or dislike? How did you use the product? What should others know before buying?";
}
