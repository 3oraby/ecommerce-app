import 'package:e_commerce_app/core/models/error_model.dart';
import 'package:e_commerce_app/features/orders/data/models/order_state_model.dart';

class CheckoutResponseModel {
  final bool status;
  final CheckoutOrderData? order;
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
        order: CheckoutOrderData.fromJson(json["data"]["order"]),
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

class CheckoutOrderData {
  final int id;
  final int userId;
  final int addressId;
  final double total;
  final String addressInDetails;
  final String updatedAt;
  final String createdAt;

  CheckoutOrderData({
    required this.id,
    required this.userId,
    required this.addressId,
    required this.total,
    required this.addressInDetails,
    required this.updatedAt,
    required this.createdAt,
  });

  // Convert JSON to CheckoutOrderData
  factory CheckoutOrderData.fromJson(Map<String, dynamic> json) {
    return CheckoutOrderData(
      id: json['id'],
      userId: json['user_id'],
      addressId: json['address_id'],
      total: json['total'].toDouble(),
      addressInDetails: json['addressInDetails'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
    );
  }

  // Convert CheckoutOrderData to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'address_id': addressId,
      'total': total,
      'addressInDetails': addressInDetails,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
    };
  }
}
