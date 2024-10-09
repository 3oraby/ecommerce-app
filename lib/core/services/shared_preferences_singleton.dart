import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesSingleton {
  static late SharedPreferences instance;

  static Future<void> init() async {
    instance = await SharedPreferences.getInstance();
  }

  static void setBool(String key, bool value) {
    log("set bool in pref $key :${(key,value)}");
    instance.setBool(key, value);
  }

  static bool getBool(String key) {
    log("get bool in pref $key :${(key)}");
    return instance.getBool(key) ?? false;
  }

  static void setString(String key, String value) {
    log("set string in pref $key :${(key, value)}");
    instance.setString(key, value);
  }

  static String? getString(String key) {
    log("get string from pref $key : ${(key)}");
    return instance.getString(key);
  }

  static void deleteStringFromSharedPreferences(String key) {
    if (instance.containsKey(key)) {
      instance.remove(key);
      log('$key has been deleted');
    } else {
      log('No value found for $key');
    }
  }

  static void deleteBoolFromSharedPreferences(String key) {
    if (instance.containsKey(key)) {
      instance.remove(key);
      log('$key has been deleted');
    } else {
      log('No value found for $key');
    }
  }
}
