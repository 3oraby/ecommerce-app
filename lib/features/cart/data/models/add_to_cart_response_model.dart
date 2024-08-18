import 'package:e_commerce_app/core/models/error_model.dart';

class AddToCartResponseModel {
  final bool status;
  final int? cartId;
  final ErrorModel? error;
  final String? message;

  AddToCartResponseModel({
    required this.status,
    this.cartId,
    this.error,
    this.message,
  });

  factory AddToCartResponseModel.fromJson({required Map<String, dynamic> json}) {
    if (json["status"] == "success") {
      return AddToCartResponseModel(
        status: true,
        cartId: json["data"]["id"]
      );
    } else {
      return AddToCartResponseModel(
        status: false,
        error: ErrorModel.fromJson(json['error']),
        message: json['message'],
      );
    }
  }
}
