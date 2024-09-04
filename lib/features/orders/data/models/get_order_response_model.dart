import 'package:e_commerce_app/core/models/error_model.dart';
import 'package:e_commerce_app/features/orders/data/models/order_items_model.dart';
import 'package:e_commerce_app/features/orders/data/models/order_model.dart';
import 'package:e_commerce_app/features/orders/data/models/order_state_model.dart';

class GetOrderResponseModel {
  final bool status;
  final OrderModel? orderModel;
  final OrderStateModel? orderStateModel;
  final List<OrderItemModel>? orderItems;
  final ErrorModel? error;
  final String? message;

  GetOrderResponseModel({
    required this.status,
    this.orderModel,
    this.orderStateModel,
    this.orderItems,
    this.error,
    this.message,
  });

  factory GetOrderResponseModel.fromJson({required Map<String, dynamic> json}) {
    if (json["status"] == "success") {
      List orderItems = json["data"]["OrderItems"];
      return GetOrderResponseModel(
        status: true,
        orderModel: OrderModel.fromJson(json["data"]),
        orderStateModel: OrderStateModel.fromJson(json["data"]["OrderState"]),
        orderItems: orderItems
            .map(
              (orderJson) => OrderItemModel.fromJson(json: orderJson),
            )
            .toList(),
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

class OrderData {
  final int id;
  final int total;
  final String date;
  final int userId;
  final int addressId;
  final String addressInDetails;
  final String createdAt;
  final String updatedAt;
  final OrderState orderState;
  final List<OrderItem> orderItems;

  OrderData({
    required this.id,
    required this.total,
    required this.date,
    required this.userId,
    required this.addressId,
    required this.addressInDetails,
    required this.createdAt,
    required this.updatedAt,
    required this.orderState,
    required this.orderItems,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'],
      total: json['total'],
      date: json['date'],
      userId: json['user_id'],
      addressId: json['address_id'],
      addressInDetails: json['addressInDetails'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      orderState: OrderState.fromJson(json['OrderState']),
      orderItems: (json['OrderItems'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
    );
  }
}

class OrderState {
  final int id;
  final String state;
  final bool payment;

  OrderState({
    required this.id,
    required this.state,
    required this.payment,
  });

  factory OrderState.fromJson(Map<String, dynamic> json) {
    return OrderState(
      id: json['id'],
      state: json['state'],
      payment: json['payment'],
    );
  }
}

class OrderItem {
  final int id;
  final int quantity;
  final int price;
  final int totalCost;
  final Product product;

  OrderItem({
    required this.id,
    required this.quantity,
    required this.price,
    required this.totalCost,
    required this.product,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      quantity: json['quantity'],
      price: json['price'],
      totalCost: json['total_cost'],
      product: Product.fromJson(json['Product']),
    );
  }
}

class Product {
  final int id;
  final String name;
  final String description;
  final int price;
  final int categoryId;
  final String photo;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.photo,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      categoryId: json['category_id'],
      photo: json['photo'],
    );
  }
}
