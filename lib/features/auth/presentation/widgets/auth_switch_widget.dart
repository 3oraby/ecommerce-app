import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class AuthSwitchWidget extends StatelessWidget {
  final String promptText;
  final String actionText;
  final VoidCallback onActionPressed;
  final Color? promptTextColor;
  final Color? actionTextColor;
  final double? promptTextSize;
  final double? actionTextSize;
  const AuthSwitchWidget({
    super.key,
    required this.promptText,
    required this.actionText,
    required this.onActionPressed,
    this.promptTextColor = Colors.black,
    this.actionTextColor = ThemeColors.primaryColor,
    this.promptTextSize = 18,
    this.actionTextSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          promptText,
          style: TextStyle(
            color: promptTextColor,
            fontSize: promptTextSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: onActionPressed,
          child: Text(
            actionText,
            style: TextStyle(
              color: actionTextColor,
              fontSize: actionTextSize,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.underline,
              decorationColor: actionTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
