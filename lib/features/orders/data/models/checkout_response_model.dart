import 'package:e_commerce_app/core/models/error_model.dart';
import 'package:e_commerce_app/features/orders/data/models/order_model.dart';
import 'package:e_commerce_app/features/orders/data/models/order_state_model.dart';

class CheckoutResponseModel {
  final bool status;
  final OrderModel? order;
  final OrderStateModel? orderState;
  final ErrorModel? error;
  final String? message;

  CheckoutResponseModel({
    required this.status,
    this.order,
    this.orderState,
    this.error,
    this.message,
  });

  factory CheckoutResponseModel.fromJson({required Map<String, dynamic> json}) {
    if (json["status"] == "success") {
      return CheckoutResponseModel(
        status: true,
        order: OrderModel.fromJson(json["data"]["order"]),
        orderState: OrderStateModel.fromJson(json["data"]["orderState"]),
      );
    } else {
      return CheckoutResponseModel(
        status: false,
        error: ErrorModel.fromJson(json["error"]),
        message: json["message"],
      );
    }
  }
}
