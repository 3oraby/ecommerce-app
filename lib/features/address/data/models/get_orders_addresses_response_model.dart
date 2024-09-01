import 'package:e_commerce_app/core/models/error_model.dart';
import 'package:e_commerce_app/features/address/data/models/orders_address_model.dart';

class GetOrdersAddressesResponseModel {
  final bool status;
  final List<OrdersAddressModel>? ordersAddresses;
  final ErrorModel? error;
  final String? message;

  GetOrdersAddressesResponseModel({
    required this.status,
    this.ordersAddresses,
    this.error,
    this.message,
  });

  factory GetOrdersAddressesResponseModel.fromJson(
      {required Map<String, dynamic> json}) {
    if (json["status"] == "success") {
      List data = json["data"];
      List<OrdersAddressModel> orderAddresses = data
          .map((jsonData) => OrdersAddressModel.fromJson(jsonData))
          .toList();

      return GetOrdersAddressesResponseModel(
        status: true,
        ordersAddresses: orderAddresses,
      );
    } else {
      return GetOrdersAddressesResponseModel(
        status: false,
        error: ErrorModel.fromJson(json['error']),
        message: json['message'],
      );
    }
  }
}
