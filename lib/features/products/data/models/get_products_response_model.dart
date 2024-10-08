import 'package:e_commerce_app/core/models/error_model.dart';
import 'package:e_commerce_app/core/models/product_model.dart';

class GetProductsCategoryResponseModel {
  final bool status;
  final List<ProductModel>? products;
  final int? totalPages;
  final int? currentPage;
  final ErrorModel? error;
  final String? message;

  GetProductsCategoryResponseModel({
    required this.status,
    this.totalPages,
    this.currentPage,
    this.products,
    this.error,
    this.message,
  });

  factory GetProductsCategoryResponseModel.fromJson(
      {required Map<String, dynamic> json}) {
    if (json["status"] == "success") {
      List dataList = json["data"];
      List<ProductModel> products =
          dataList.map((json) => ProductModel.fromJson(json: json)).toList();

      return GetProductsCategoryResponseModel(
        status: true,
        products: products,
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
      );
    } else {
      return GetProductsCategoryResponseModel(
        status: false,
        error: ErrorModel.fromJson(json['error']),
        message: json['message'],
      );
    }
  }
}
