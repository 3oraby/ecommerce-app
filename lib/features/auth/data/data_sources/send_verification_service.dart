import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';

class SendVerificationService {
  Future<bool> sendVerification({
    required String email,
  }) async {
    try {
      Response response = await Api().post(
        url: "${ApiConstants.baseUrl}${ApiConstants.sendVerificationPoint}",
        jsonData: {"email": email},
      );

      if (response.data["status"] == "success") {
        return true;
      } else {
        log("Error in sendVerificationService: ${response.data["message"]}");
        return false;
      }
    } catch (e) {
      throw Exception(
          "there was an error in the server now ,please try again later");
    }
  }
}
