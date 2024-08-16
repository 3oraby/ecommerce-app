
import 'package:e_commerce_app/core/models/error_model.dart';
import 'package:e_commerce_app/core/models/product_model.dart';

class GetFavoritesResponseModel {
  final bool status;
  final List<ProductModel>? favoriteProducts;
  final ErrorModel? error;
  final String? message;

  GetFavoritesResponseModel({
    required this.status,
    this.favoriteProducts,
    this.error,
    this.message,
  });

  factory GetFavoritesResponseModel.fromJson({required dynamic json}) {
    if (json["status"] == "success") {
      List dataList = json["data"]["products"];
      List<ProductModel> favoriteProducts =
          dataList.map((json) => ProductModel.fromJson(json: json)).toList();
      return GetFavoritesResponseModel(
        status: true,
        favoriteProducts: favoriteProducts,
      );
    } else {
      return GetFavoritesResponseModel(
        status: false,
        error: ErrorModel.fromJson(json['error']),
        message: json['message'],
      );
    }
  }
}
