import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';
import 'package:e_commerce_app/features/auth/data/models/get_user_response_model.dart';

class GetUserService {
  static Future<GetUserResponseModel> getUser() async {
    try {
      Response response = await Api().get(
        url: "${ApiConstants.baseUrl}${ApiConstants.getUserEndPoint}",
      );
      return GetUserResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception(
          "there was an error in the server now ,please try again later");
    }
  }
}
