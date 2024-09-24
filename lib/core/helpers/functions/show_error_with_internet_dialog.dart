import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:flutter/material.dart';

void showErrorWithInternetDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Error',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        content: const Text(
          "Oops! It looks like you're offline. Please check your internet connection.",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          CustomTriggerButton(
            buttonHeight: 40,
            backgroundColor: ThemeColors.actionButtonsBackgroundColor,
            description: "OK",
            descriptionSize: 20,
            descriptionColor: ThemeColors.primaryColor,
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
