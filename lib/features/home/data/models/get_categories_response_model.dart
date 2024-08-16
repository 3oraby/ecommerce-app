import 'package:e_commerce_app/core/models/category_model.dart';
import 'package:e_commerce_app/core/models/error_model.dart';

class GetCategoriesResponseModel {
  final bool status;
  final List<CategoryModel>? categories;
  final ErrorModel? error;
  final String? message;

  GetCategoriesResponseModel({
    required this.status,
    this.categories,
    this.error,
    this.message,
  });

  factory GetCategoriesResponseModel.fromJson({required dynamic json}) {
    if (json is List) {
      List<CategoryModel> categories =
          json.map((json) => CategoryModel.fromJson(json: json)).toList();
      return GetCategoriesResponseModel(
        status: true,
        categories: categories,
      );
    } else if (json is Map<String, dynamic>) {
      // Failure case: error structure
      return GetCategoriesResponseModel(
        status: false,
        error: ErrorModel.fromJson(json['error']),
        message: json['message'],
      );
    } else {
      // Unknown response structure
      throw Exception('Unexpected JSON format');
    }
  }
}
