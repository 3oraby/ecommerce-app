import 'package:e_commerce_app/core/utils/theme/colors.dart';
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
        vertical: 8,
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Country",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    VerticalGap(8),
                    Text(
                      "City",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    VerticalGap(8),
                    Text(
                      "Address Details",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ordersAddressModel.address.country,
                        textAlign: TextAlign.center,
                      ),
                      const VerticalGap(8),
                      Text(
                        ordersAddressModel.address.city,
                        textAlign: TextAlign.center,
                      ),
                      const VerticalGap(8),
                      Text(
                        ordersAddressModel.addressInDetails,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
