import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';

class CancelItemFromOrderService {
  Future<bool> cancelItem({
    required int orderId,
    required int orderItemId,
  }) async {
    try {
      Response response = await Api().delete(
        url:
            "${ApiConstants.baseUrl}${ApiConstants.cancelItemFromOrder(orderId: orderId, orderItemId: orderItemId)}",
      );
      if (response.data["status"] == "success"){
        return true;
      }
      return false;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
