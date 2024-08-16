import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';
import 'package:e_commerce_app/features/products/data/models/get_all_products_response_model.dart';

class GetHomeDetailsService {
  Future<GetAllProductsResponseModel> getAllProducts() async {
    try {
      Response response = await Api().get(
        url: "${ApiConstants.baseUrl}${ApiConstants.getProductsEndPoint}",
      );
      return GetAllProductsResponseModel.fromJson(json: response.data);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
