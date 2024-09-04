import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';
import 'package:e_commerce_app/features/orders/data/models/get_order_response_model.dart';

class GetOrderDataService {
  Future<GetOrderResponseModel> getOrder({required int orderId}) async {
    try {
      Response response = await Api().get(
        url: "${ApiConstants.baseUrl}${ApiConstants.getOrderEndPoint}$orderId",
      );

      return GetOrderResponseModel.fromJson(json: response.data);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
