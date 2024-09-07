import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';
import 'package:e_commerce_app/features/orders/data/models/get_all_orders_response_model.dart';

class GetAllOrdersService {
  Future<GetAllOrdersResponseModel> getAllOrder({required int userId}) async {
    try {
      Response response = await Api().get(
        url: "${ApiConstants.baseUrl}${ApiConstants.getAllOrdersEndPoint}$userId",
      );

      return GetAllOrdersResponseModel.fromJson(json: response.data);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
