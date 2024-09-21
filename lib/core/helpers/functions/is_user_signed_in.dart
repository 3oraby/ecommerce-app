import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';

bool isUserSignedIn() {
  String accessToken = SharedPreferencesSingleton.getString(
          LocalConstants.accessTokenNameInPref) ??
      "";

  return !(accessToken == "");
}
