import 'dart:developer';

import 'package:dio/dio.dart';

String extractRefreshToken({
  required Response response,
}) {
  // Extract 'set-cookie' header
  String? setCookie = response.headers['set-cookie']?.first;

  if (setCookie != null) {
    // Extract the refreshToken from the 'set-cookie' string
    RegExp regExp = RegExp(r'refreshToken=([^;]+)');
    Match? match = regExp.firstMatch(setCookie);
    String refreshToken;
    if (match != null) {
      refreshToken = match.group(1)!;
      log('Refresh Token: $refreshToken');
    } else {
      refreshToken = "";
      log('Refresh token not found in set-cookie');
    }
    return refreshToken;
  } else {
    print('set-cookie header not found');
  }
  return "";
}
