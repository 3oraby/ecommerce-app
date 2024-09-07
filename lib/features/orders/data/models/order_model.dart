
import 'dart:developer';

import 'package:e_commerce_app/features/orders/data/models/order_items_model.dart';
import 'package:e_commerce_app/features/orders/data/models/order_state_model.dart';

class OrderModel {
  final int id;
  final int userId;
  final int addressId;
  final double total;
  final String addressInDetails;
  final OrderStateModel orderStateModel;
  final List<OrderItemModel> orderItems;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.addressId,
    required this.total,
    required this.addressInDetails,
    required this.orderStateModel,
    required this.orderItems,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List orderItems = json["OrderItems"];
    log("DDDDD " + json[""].runtimeType.toString());
    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      addressId: json['address_id'],
      total: double.parse(json['total']),
      addressInDetails: json['addressInDetails'],
      orderStateModel: OrderStateModel.fromJson(json["OrderState"]),
      orderItems: orderItems
          .map(
            (jsonItem) => OrderItemModel.fromJson(json: jsonItem),
          )
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
