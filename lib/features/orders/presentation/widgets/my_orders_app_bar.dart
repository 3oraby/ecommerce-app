import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';

class MyOrdersAppBar {
  static AppBar getMyOrdersAppBar() {
    return AppBar(
      title: Text(
        "Orders",
        style: TextStyles.aDLaMDisplayBlackBold26,
      ),
    );
  }
}
