import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CartAppBar {
  static AppBar getCartAppBar() {
    return AppBar(
      title: Text(
        "cart",
        style: TextStyles.aDLaMDisplayBlackBold32,
      ),
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
    );
  }
}
