import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/address/presentation/widgets/choose_address_widgets/choose_address_loaded_body.dart';
import 'package:flutter/material.dart';

class ChooseAddressPage extends StatelessWidget {
  const ChooseAddressPage({super.key});
  static const id = "/choose_address_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundBodiesColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        title: Text(
          "Your addresses",
          style: TextStyles.aDLaMDisplayBlackBold22,
        ),
      ),
      body: const ChooseAddressLoadedBody(),
    );
  }
}