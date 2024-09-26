import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  Color backgroundColor = ThemeColors.mainLabelsColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 21,
        ),
      ),
      backgroundColor: backgroundColor,
      showCloseIcon: true,
      animation: CurvedAnimation(
        curve: Curves.bounceIn,
        parent: kAlwaysCompleteAnimation,
      ),
    ),
  );
}
