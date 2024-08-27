import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/features/address/presentation/pages/add_address_page.dart';
import 'package:flutter/material.dart';

class ChooseAddressLoadedBody extends StatelessWidget {
  const ChooseAddressLoadedBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            child: ListView(
              children: [
                CustomTriggerButton(
                  buttonHeight: screenHeight * 0.06,
                  backgroundColor: ThemeColors.backgroundBodiesColor,
                  borderWidth: 2,
                  borderColor: ThemeColors.primaryColor,
                  description: "ADD A NEW ADDRESS",
                  descriptionColor: ThemeColors.primaryColor,
                  descriptionSize: 22,
                  onPressed: () {
                    Navigator.pushNamed(context, AddAddressPage.id);
                  },
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: screenHeight / 9,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTriggerButton(
                description: "CONFIRM",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
