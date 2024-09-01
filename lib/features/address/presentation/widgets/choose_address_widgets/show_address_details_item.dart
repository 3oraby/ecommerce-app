import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/features/address/data/models/orders_address_model.dart';

class ShowAddressDetailsItem extends StatelessWidget {
  const ShowAddressDetailsItem({
    super.key,
    required this.ordersAddressModel,
    required this.isSelectedAddress,
  });

  final OrdersAddressModel ordersAddressModel;
  final bool isSelectedAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          LocalConstants.kBorderRadius,
        ),
        border: Border.all(
          color:
              isSelectedAddress ? ThemeColors.primaryColor : Colors.grey[300]!,
          width: isSelectedAddress ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.share_location_sharp,
                color: Colors.grey[600],
                size: 26,
              ),
              const SizedBox(width: 8),
              Text(
                "Home",
                style: TextStyles.aDLaMDisplayBlackBold20,
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {
                  //! Navigate to the edit address page with the initial data of this address
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.grey[600],
                  size: 20,
                ),
                label: Text(
                  "Edit",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey[300],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddressDetailsRow(
                  label: "Country",
                  labelData: ordersAddressModel.address.country,
                ),
                const VerticalGap(16),
                AddressDetailsRow(
                  label: "City",
                  labelData: ordersAddressModel.address.city,
                ),
                const VerticalGap(16),
                AddressDetailsRow(
                  label: "Address Details",
                  labelData: ordersAddressModel.addressInDetails,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddressDetailsRow extends StatelessWidget {
  const AddressDetailsRow({
    super.key,
    required this.label,
    required this.labelData,
  });

  final String label;
  final String labelData;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
     crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: (screenWidth - 4 * LocalConstants.kHorizontalPadding) * 0.3,
          child: Text(label),
        ),
        const HorizontalGap(8),
        Expanded(
          child: Text(
            labelData,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
