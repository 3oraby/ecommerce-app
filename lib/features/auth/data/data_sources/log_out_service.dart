import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/features/auth/data/models/log_out_response_model.dart';
import 'package:e_commerce_app/core/helpers/api.dart';

class LogOutService {
  Future<LogOutResponseModel> logOut() async {
    try {
      Response response = await Api().post(
        url: "${ApiConstants.baseUrl}${ApiConstants.logOutEndPoint}",
      );
      return LogOutResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }
}
