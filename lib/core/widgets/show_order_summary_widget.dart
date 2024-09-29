import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:flutter/material.dart';

class ShowOrderSummaryWidget extends StatelessWidget {
  const ShowOrderSummaryWidget({
    super.key,
    required this.subTotal,
    this.showPaymentSection = false,
  });
  final String subTotal;
  final bool showPaymentSection;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: LocalConstants.internalPadding,
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
          const Row(
            children: [
              Text(
                "Order Summary",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
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
                  fontSize: 20,
                ),
              ),
              Text(
                "EGP $subTotal",
                style: const TextStyle(
                  fontSize: 20,
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
                  fontSize: 20,
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
            color: ThemeColors.backgroundBodiesColor,
            thickness: 2,
          ),
          const VerticalGap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                "EGP $subTotal",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Visibility(
            visible: showPaymentSection,
            child: const Column(
              children: [
                VerticalGap(10),
                Divider(
                  color: ThemeColors.backgroundBodiesColor,
                  thickness: 2,
                ),
                VerticalGap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Payment Method",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Spacer(flex: 10),
                    Icon(
                      Icons.money_rounded,
                      color: ThemeColors.subLabelsColor,
                    ),
                    Spacer(flex: 1),
                    Text(
                      "Cash on Delivery",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ThemeColors.mainLabelsColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
