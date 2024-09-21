import 'dart:convert';

import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';

UserModel? getUserStoredModel() {
  try {
    String? jsonString =
        SharedPreferencesSingleton.getString(LocalConstants.userModelNameInPref);
    if (jsonString != null && jsonString.isNotEmpty) {
      return UserModel.fromJson(jsonDecode(jsonString));
    }
    return null;
  } catch (e) {
    throw Exception("Error decoding user model: $e");
  }
}
