class CheckoutRequestModel {
  String? method;
  String? addressInDetails;

  CheckoutRequestModel({
    this.method = "cash",
    this.addressInDetails,
  });

  Map<String,dynamic> toJson() {
    return {
      "method": method,
      "addressInDetails": addressInDetails,
    };
  }
}
