import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';
import 'package:e_commerce_app/features/home/data/models/get_categories_response_model.dart';

class GetCategoriesService {
  Future<GetCategoriesResponseModel> getCategories() async {
    try {
      Response response = await Api().get(
        url: "${ApiConstants.baseUrl}${ApiConstants.getCategoriesEndPoint}",
      );
      return GetCategoriesResponseModel.fromJson(json: response.data);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
