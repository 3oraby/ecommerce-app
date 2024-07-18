import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferencesService {
  static Future<bool> isAppFirstTimeOpened() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isFirstTime = preferences.getBool("isFirstTime") ?? true;
    return isFirstTime;
  }

  static Future<void> markOnboardingComplete() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool("isFirstTime", false);
  }
}
