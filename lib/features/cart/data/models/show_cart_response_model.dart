import 'package:e_commerce_app/core/models/error_model.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';

class ShowCartResponseModel {
  final bool status;
  final List<CartItemModel>? cartItems;
  final ErrorModel? error;
  final String? message;

  ShowCartResponseModel({
    required this.status,
    this.cartItems,
    this.error,
    this.message,
  });

  factory ShowCartResponseModel.fromJson({required Map<String, dynamic> json}) {
    if (json["status"] == "success") {
      List dataList = json["data"]["CartItems"];
      List<CartItemModel> cartItems =
          dataList.map((jsonData) => CartItemModel.fromJson(json: jsonData)).toList();
      return ShowCartResponseModel(
        status: true,
        cartItems: cartItems,
      );
    } else {
      return ShowCartResponseModel(
        status: false,
        error: ErrorModel.fromJson(json['error']),
        message: json['message'],
      );
    }
  }
}
