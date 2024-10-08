import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';

class CheckIsEmailVerifiedService {
  Future<bool> isEmailVerified({
    required String email,
  }) async {
    try {
      Response response = await Api().post(
        url: "${ApiConstants.baseUrl}${ApiConstants.checkIsEmailVerifiedEndPoint}",
        jsonData: {"email": email},
      );

      if (response.data["status"] == "success") {
        return true;
      } else {
        log("Error in CheckIsEmailVerifiedService: ${response.data["message"]}");
        return false;
      }
    } catch (e) {
      throw Exception(
          "there was an error in the server now ,please try again later");
    }
  }
}
