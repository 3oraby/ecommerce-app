import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';

class UpdateUserService {
  Future<bool> updateUser({
    required int userId,
    required Map<String, dynamic> jsonData,
  }) async {
    try {
      Response response = await Api().patch(
        url: "${ApiConstants.baseUrl}${ApiConstants.updateUserEndPoint}$userId",
        jsonData: jsonData,
      );
      return response.data["status"] == "success";
    } catch (e) {
      throw Exception(
          "there was an error in the server now ,please try again later");
    }
  }
}
