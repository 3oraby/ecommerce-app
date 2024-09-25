import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/extract_refresh_token.dart';
import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce_app/features/auth/data/models/login_response_model.dart';
import 'package:e_commerce_app/core/helpers/api.dart';

class LoginService {
  Future<LoginResponseModel> verifyLogin({
    required Map<String, dynamic> jsonData,
  }) async {
    try {
      log(jsonData.toString());
      Response response = await Api().post(
        url: "${ApiConstants.baseUrl}${ApiConstants.loginEndPoint}",
        jsonData: jsonData,
      );
      // log("headers ${response.headers}");
      String refreshToken = extractRefreshToken(response: response) ;
      // save the refresh token in shared preferences
      SharedPreferencesSingleton.setString(LocalConstants.refreshTokenNameInPref, refreshToken);
      return LoginResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception("Connection timed out. Please try again later.");
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            "Received invalid status code: ${e.response?.statusCode}");
      } else if (e.type == DioExceptionType.cancel) {
        throw Exception("Request to server was canceled.");
      } else {
        throw Exception("An unexpected error occurred: ${e.message}");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }
}
