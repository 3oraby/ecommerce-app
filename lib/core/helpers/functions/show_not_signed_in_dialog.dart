import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/features/auth/presentation/pages/entry_page.dart';
import 'package:flutter/material.dart';

void showNotSignedInDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('not Signed in'),
        content: const Text('Are you want to go for sign in now?'),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'No',
              style: TextStyle(
                color: ThemeColors.primaryColor,
                fontSize: 20,
              ),
            ),
          ),
          CustomTriggerButton(
            buttonWidth: 100,
            buttonHeight: 40,
            backgroundColor: ThemeColors.actionButtonsBackgroundColor,
            description: "YES",
            descriptionSize: 20,
            descriptionColor: ThemeColors.successfullyDoneColor,
            onPressed: () async {
              Navigator.pushReplacementNamed(context, EntryPage.id);
            },
          ),
        ],
      );
    },
  );
}
