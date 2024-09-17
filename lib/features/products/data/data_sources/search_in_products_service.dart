



import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';
import 'package:e_commerce_app/features/products/data/models/get_products_response_model.dart';

class SearchInProductsService {
  Future<GetProductsCategoryResponseModel> searchInProducts({
    required String productName,
    required int categoryId,
  }) async {
    try {
      Response response = await Api().get(
        url: "${ApiConstants.baseUrl}${ApiConstants.searchInProductsEndPoint}",
        queryParams: {
          "q": productName,
          "categoryId": categoryId,
        }
      );
      return GetProductsCategoryResponseModel.fromJson(json: response.data);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
