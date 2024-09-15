import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';

class SettingsAppBar {
  static AppBar getSettingsAppBar() {
    return AppBar(
      title: Text(
        "Settings",
        style: TextStyles.aDLaMDisplayBlackBold26,
      ),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
    );
  }
}
