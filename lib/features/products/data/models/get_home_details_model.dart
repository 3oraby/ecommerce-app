
import 'package:e_commerce_app/core/models/category_model.dart';
import 'package:e_commerce_app/core/models/error_model.dart';
import 'package:e_commerce_app/core/models/product_model.dart';

class GetHomeDetailsModel {
  final bool status;
  final List<CategoryModel>? categories;
  final List<ProductModel>? products;
  final ErrorModel? error;
  final String? message;

  GetHomeDetailsModel({
    required this.status,
    this.categories,
    this.products,
    this.error,
    this.message,
  });

  factory GetHomeDetailsModel.fromJson(
      {required Map<String, dynamic> json}) {
    if (json["status"] == "success") {
      List dataList = json["data"];
      List<ProductModel> products = dataList
          .map((json) => ProductModel.fromJson(json: json))
          .toList();

      return GetHomeDetailsModel(
        status: true,
        products: products,
      );
    } else {
      return GetHomeDetailsModel(
        status: false,
        error: ErrorModel.fromJson(json['error']),
        message: json['message'],
      );
    }
  }
}
