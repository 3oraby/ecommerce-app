import 'package:e_commerce_app/core/models/error_model.dart';
import 'package:e_commerce_app/features/orders/data/models/order_model.dart';

class GetOrderResponseModel {
  final bool status;
  final OrderModel? orderModel;
  final ErrorModel? error;
  final String? message;

  GetOrderResponseModel({
    required this.status,
    this.orderModel,
    this.error,
    this.message,
  });

  factory GetOrderResponseModel.fromJson({required Map<String, dynamic> json}) {
    if (json["status"] == "success") {
      return GetOrderResponseModel(
        status: true,
        orderModel: OrderModel.fromJson(json["data"]),
      );
    } else {
      return GetOrderResponseModel(
        status: false,
        error: ErrorModel.fromJson(json["error"]),
        message: json["message"],
      );
    }
  }
}
