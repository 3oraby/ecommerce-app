import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/extract_refresh_token.dart';
import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce_app/features/auth/data/models/verify_email_response_model.dart';
import 'package:e_commerce_app/core/helpers/api.dart';

class VerifyEmailService {
  Future<VerifyEmailResponseModel> verifyEmail({
    required String email,
    required String token,
  }) async {
    try {
      Response response = await Api().get(
        url:
            "${ApiConstants.baseUrl}${ApiConstants.verifyEmailEndPoint}token=$token&email=$email",
      );
      String refreshToken = extractRefreshToken(response: response);
      // save the refresh token in shared preferences
      SharedPreferencesSingleton.setString(
          LocalConstants.refreshTokenNameInPref, refreshToken);
      return VerifyEmailResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception(
          "there was an error in the server now ,please try again later");
    }
  }
}
