import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:flutter/material.dart';

class ShipmentInfo extends StatelessWidget {
  final int itemsCount;

  const ShipmentInfo({
    super.key,
    required this.itemsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.2,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Shipment",
            style: TextStyles.aDLaMDisplayBlackBold20,
          ),
          const HorizontalGap(16),
          Text(
            "($itemsCount items)",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
