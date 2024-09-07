

import 'package:e_commerce_app/core/models/error_model.dart';
import 'package:e_commerce_app/features/orders/data/models/order_model.dart';

class GetAllOrdersResponseModel {
  final bool status;
  final List<OrderModel>? userOrders;
  final ErrorModel? error;
  final String? message;

  GetAllOrdersResponseModel({
    required this.status,
    this.userOrders,
    this.error,
    this.message,
  });

  factory GetAllOrdersResponseModel.fromJson(
      {required Map<String, dynamic> json}) {
    if (json["status"] == "success") {
      List orders = json["data"];
      return GetAllOrdersResponseModel(
        status: true,
        userOrders: orders
            .map(
              (jsonOrder) => OrderModel.fromJson(jsonOrder),
            )
            .toList(),
      );
    } else {
      return GetAllOrdersResponseModel(
        status: false,
        error: ErrorModel.fromJson(json["error"]),
        message: json["message"],
      );
    }
  }
}
