
import 'package:e_commerce_app/constants/api_constants.dart';

String getPhotoUrl(String photoPath) {
  return '${ApiConstants.baseUrl}${ApiConstants.getPhotoEndPoint}$photoPath';
}
