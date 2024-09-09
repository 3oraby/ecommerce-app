import 'package:e_commerce_app/core/models/product_model.dart';

class OrderItemModel {
  final int id;
  final int quantity;
  final int price;
  final int totalCost;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProductModel product;

  OrderItemModel({
    required this.id,
    required this.quantity,
    required this.price,
    required this.totalCost,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory OrderItemModel.fromJson({required Map<String, dynamic> json}) {
    return OrderItemModel(
      id: json['id'],
      quantity: json['quantity'],
      price: (json['price']),
      totalCost: (json['total_cost']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      product: ProductModel.fromJson(json: json['Product']),
    );
  }
}
