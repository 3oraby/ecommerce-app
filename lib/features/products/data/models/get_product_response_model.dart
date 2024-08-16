import 'package:e_commerce_app/models/error_model.dart';
import 'package:e_commerce_app/models/product_model.dart';

class GetProductResponseModel {
  final bool status;
  final ProductModel? data;
  final ErrorModel? error;
  final String? message;

  GetProductResponseModel({
    required this.status,
    this.data,
    this.error,
    this.message,
  });

  factory GetProductResponseModel.fromJson({required Map<String, dynamic> json}) {
    if (json['status'] == 'success') {
      return GetProductResponseModel(
        status: true,
        data: ProductModel.fromJson(json: json['data']),
      );
    } else {
      return GetProductResponseModel(
        status: false,
        error: ErrorModel.fromJson(json['error']),
        message: json['message'],
      );
    }
  }


}
