import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/extract_refresh_token.dart';
import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce_app/features/auth/data/models/register_response_model.dart';
import 'package:e_commerce_app/core/helpers/api.dart';

class RegisterService {
  Future<RegisterResponseModel> createAccount({
    required Map<String, dynamic> jsonData,
  }) async {
    try {
      Response response = await Api().post(
        url: "${ApiConstants.baseUrl}${ApiConstants.registerEndPoint}",
        jsonData: jsonData,
      );
      String refreshToken = extractRefreshToken(response: response);
      // save the refresh token in shared preferences
      SharedPreferencesSingleton.setString(
          LocalConstants.refreshTokenNameInPref, refreshToken);
      return RegisterResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception(
          "there was an error in the server now ,please try again later");
    }
  }
}
