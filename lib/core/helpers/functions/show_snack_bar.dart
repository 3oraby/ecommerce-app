import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 21,
        ),
      ),
      backgroundColor: ThemeColors.primaryColor,
      showCloseIcon: true,
      animation: CurvedAnimation(
        curve: Curves.bounceIn,
        parent: kAlwaysCompleteAnimation,
      ),
    ),
  );
}
