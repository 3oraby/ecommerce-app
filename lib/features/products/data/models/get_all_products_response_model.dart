
import 'package:e_commerce_app/models/error_model.dart';
import 'package:e_commerce_app/models/product_model.dart';

class GetAllProductsResponseModel {
  final bool status;
  final List<ProductModel>? products;
  final ErrorModel? error;
  final String? message;

  GetAllProductsResponseModel({
    required this.status,
    this.products,
    this.error,
    this.message,
  });

  factory GetAllProductsResponseModel.fromJson(
      {required dynamic json}) {
    if (json is List) {
      List<ProductModel> products = json
          .map((json) => ProductModel.fromJson(json: json))
          .toList();

      return GetAllProductsResponseModel(
        status: true,
        products: products,
      );
    } else {
      return GetAllProductsResponseModel(
        status: false,
        error: ErrorModel.fromJson(json['error']),
        message: json['message'],
      );
    }
  }
}
