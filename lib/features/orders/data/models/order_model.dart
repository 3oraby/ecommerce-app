import 'package:e_commerce_app/features/address/data/models/orders_address_model.dart';
import 'package:e_commerce_app/features/orders/data/models/order_items_model.dart';
import 'package:e_commerce_app/features/orders/data/models/order_state_model.dart';

class OrderModel {
  final int id;
  final int userId;
  final int addressId;
  final int total;
  final String addressInDetails;
  final OrderStateModel orderStateModel;
  final List<OrderItemModel> orderItems;
  final OrdersAddressModel ordersAddressModel;
  final String createdAt;
  final String updatedAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.addressId,
    required this.total,
    required this.addressInDetails,
    required this.orderStateModel,
    required this.orderItems,
    required this.ordersAddressModel,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List orderItems = json["OrderItems"];
    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      addressId: json['address_id'],
      total: json['total'],
      addressInDetails: json['addressInDetails'],
      orderStateModel: OrderStateModel.fromJson(json["OrderState"]),
      orderItems: orderItems
          .map(
            (jsonItem) => OrderItemModel.fromJson(json: jsonItem),
          )
          .toList(),
      ordersAddressModel: OrdersAddressModel(
        addressId: json["address_id"],
        country: json["Address"]["country"],
        city: json["Address"]["city"],
        addressInDetails: json["addressInDetails"],
      ),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
