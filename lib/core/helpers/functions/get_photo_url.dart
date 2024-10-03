import 'dart:developer';

import 'package:e_commerce_app/constants/api_constants.dart';

String getPhotoUrl(String photoPath) {
  // log("${ApiConstants.baseUrl}${ApiConstants.getPhotoEndPoint}$photoPath");
  return '${ApiConstants.baseUrl}${ApiConstants.getPhotoEndPoint}$photoPath';
}
