import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';
import 'package:e_commerce_app/features/products/data/models/get_products_response_model.dart';

class GetProductByCategoryService {
  Future<GetProductsCategoryResponseModel> getProductsByCategory({
    required int categoryId,
    Map<String, dynamic> ?queryParams,
  }) async {
    try {

      log(queryParams.toString());
      Response response = await Api().get(
        url:
            "${ApiConstants.baseUrl}${ApiConstants.getCategoryProductsEndPoint}$categoryId",
        queryParams: queryParams,
      );

      return GetProductsCategoryResponseModel.fromJson(json: response.data);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
