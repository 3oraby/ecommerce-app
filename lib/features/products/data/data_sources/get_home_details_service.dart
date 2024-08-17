import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';
import 'package:e_commerce_app/features/products/data/models/get_home_details_model.dart';

class GetHomeDetailsService {
  Future<GetHomeDetailsResponseModel> getHomeData() async {
    try {
      Response response = await Api().get(
        url: "${ApiConstants.baseUrl}${ApiConstants.getHomeDataEndPoint}",
      );
      return GetHomeDetailsResponseModel.fromJson(json: response.data);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
