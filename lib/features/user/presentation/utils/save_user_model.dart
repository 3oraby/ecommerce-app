
import 'dart:convert';

import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';

void saveUserModel(UserModel user){
  String jsonString = jsonEncode(user);
  SharedPreferencesSingleton.setString(LocalConstants.userModelNameInPref, jsonString);
}