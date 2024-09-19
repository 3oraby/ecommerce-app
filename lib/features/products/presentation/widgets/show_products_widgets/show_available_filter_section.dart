import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:flutter/material.dart';

class ShowAvailableFilterSection extends StatelessWidget {
  const ShowAvailableFilterSection({
    super.key,
    required this.priceFilterApplied,
    required this.onPriceFilterPressed,
  });

  final bool priceFilterApplied;
  final void Function(BuildContext context) onPriceFilterPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: LocalConstants.internalPadding,
      child: Row(
        children: [
          CustomTriggerButton(
            buttonHeight: 45,
            buttonWidth: 120,
            backgroundColor: priceFilterApplied
                ? Colors.white
                : ThemeColors.actionButtonsBackgroundColor,
            onPressed: () {
              onPriceFilterPressed(context);
            },
            borderWidth: priceFilterApplied ? 2 : 0,
            borderColor:
                priceFilterApplied ? ThemeColors.primaryColor : Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.money,
                  color: priceFilterApplied
                      ? ThemeColors.primaryColor
                      : Colors.black,
                ),
                const HorizontalGap(4),
                Text(
                  "Price",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: priceFilterApplied
                        ? ThemeColors.primaryColor
                        : Colors.black,
                  ),
                ),
                const HorizontalGap(4),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: priceFilterApplied
                      ? ThemeColors.primaryColor
                      : Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
