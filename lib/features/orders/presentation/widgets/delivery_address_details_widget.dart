import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/address/data/models/orders_address_model.dart';
import 'package:e_commerce_app/features/address/presentation/widgets/choose_address_widgets/show_address_details_item.dart';
import 'package:flutter/material.dart';

class DeliveryAddressDetailsWidget extends StatelessWidget {
  const DeliveryAddressDetailsWidget({
    super.key,
    required this.orderAddress,
    this.internalPadding = LocalConstants.internalPadding,
    this.borderRadius = 0,
  });
  final OrdersAddressModel orderAddress;
  final EdgeInsets internalPadding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: internalPadding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                "Delivery address",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              HorizontalGap(6),
              Text(
                "(Home)",
                style: TextStyle(
                  color: ThemeColors.subLabelsColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const VerticalGap(10),
          ShowAddressDetailsItem(
            ordersAddressModel: orderAddress,
            isSelectedAddress: false,
            normalBorderWidth: 0,
            showFirstLine: false,
            internalPadding: false,
          ),
        ],
      ),
    );
  }
}
