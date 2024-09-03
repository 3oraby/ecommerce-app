import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:flutter/material.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    super.key,
    required this.subTotal,
  });
  final double subTotal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.3,
          color: Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Order Summary",
                style: TextStyles.aDLaMDisplayBlackBold24,
              ),
            ],
          ),
          const VerticalGap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Subtotal",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              Text(
                "EGP $subTotal",
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
            ],
          ),
          const VerticalGap(10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shipping Fee",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              Text(
                "FREE",
                style: TextStyle(
                  fontSize: 22,
                  color: ThemeColors.successfullyDoneColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const VerticalGap(10),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
          ),
          const VerticalGap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              Text(
                "EGP $subTotal",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
