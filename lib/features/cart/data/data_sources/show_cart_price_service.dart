import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';

class ShowCartPriceService {
  static Future<String> getPrice() async {
    try {
      Response response = await Api().get(
        url: "${ApiConstants.baseUrl}${ApiConstants.showPriceEndPoint}",
      );
      if (response.data["status"] == "success"){
        return response.data["price"]["total_price"];
      }else{
        throw Exception(response.data["message"]);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
