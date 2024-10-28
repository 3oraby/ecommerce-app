import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomQuantityButtonWidget extends StatelessWidget {
  const CustomQuantityButtonWidget({
    super.key,
    required this.onTap,
    required this.productAmount,
    this.isMaxQuantity = false,
  });

  final VoidCallback onTap;
  final int productAmount;
  final bool isMaxQuantity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65,
        width: 80,
        decoration: BoxDecoration(
          color: isMaxQuantity ? ThemeColors.unEnabledColor : Colors.white,
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(LocalConstants.kBorderRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "QTY",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "$productAmount",
              style: TextStyles.aDLaMDisplayBlackBold24,
            ),
          ],
        ),
      ),
    );
  }
}
