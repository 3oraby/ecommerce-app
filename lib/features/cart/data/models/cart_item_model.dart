import 'package:e_commerce_app/core/models/product_model.dart';

class CartItemModel {
  final int id;
  int quantity;
  final int cartId;
  final int productId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProductModel product;

  CartItemModel({
    required this.id,
    required this.quantity,
    required this.cartId,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory CartItemModel.fromJson({required Map<String, dynamic> json}) {
    return CartItemModel(
      id: json['id'],
      quantity: json['quantity'],
      cartId: json['cart_id'],
      productId: json['product_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      product: ProductModel.fromJson(json: json['Product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'cart_id': cartId,
      'product_id': productId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'Product': product.toJson(),
    };
  }
}
