class MakeReviewRequestModel {
  int? rate;
  String? reviewState;

  MakeReviewRequestModel({this.rate, this.reviewState});

  Map<String, dynamic> toJson() {
    return {
      "rate": rate,
      "description": reviewState,
    };
  }

  bool isRateNull() {
    return rate == null;
  }
}
