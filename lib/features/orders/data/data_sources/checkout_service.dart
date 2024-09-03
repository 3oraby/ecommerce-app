import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';
import 'package:e_commerce_app/features/orders/data/models/checkout_response_model.dart';

class CheckoutService {
  Future<CheckoutResponseModel> checkout(
      {required Map<String, dynamic> jsonData}) async {
    try {
      Response response = await Api().post(
        url: "${ApiConstants.baseUrl}${ApiConstants.checkoutEndPoint}",
        jsonData: jsonData,
      );

      return CheckoutResponseModel.fromJson(json: response.data);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
