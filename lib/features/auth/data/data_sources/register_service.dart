import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/extract_refresh_token.dart';
import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce_app/core/helpers/api.dart';

class RegisterService {
  Future<void> createAccount({
    required Map<String, dynamic> jsonData,
  }) async {
    try {
      Response response = await Api().post(
        url: "${ApiConstants.baseUrl}${ApiConstants.registerEndPoint}",
        jsonData: jsonData,
      );

      if (response.data["status"] != "success") {
        String message = response.data["message"];

        if (message == "Validation error") {
          log("11111111");
          throw Exception("Email is already in use");
        } else {
          throw Exception("Server error. Please try again later.");
        }
      }

      String refreshToken = extractRefreshToken(response: response);
      SharedPreferencesSingleton.setString(
          LocalConstants.refreshTokenNameInPref, refreshToken);
    } catch (e) {
      if (e is Exception && e.toString().contains("Email is already in use")) {
        rethrow;
      }
      throw Exception(
          "There was an error on the server. Please try again later.");
    }
  }
}
