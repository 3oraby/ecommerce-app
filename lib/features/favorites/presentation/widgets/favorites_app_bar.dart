import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';

class FavoritesAppBar {
  static AppBar getFavoritesAppBar() {
    return AppBar(
      title: Text(
        "my favorites",
        style: TextStyles.aDLaMDisplayBlackBold24,
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
}
