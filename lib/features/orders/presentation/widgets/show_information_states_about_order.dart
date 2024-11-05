import 'package:e_commerce_app/core/helpers/functions/format_string_into_date_time.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/features/orders/data/models/order_model.dart';
import 'package:flutter/material.dart';

class ShowInformationStatesAboutOrder extends StatelessWidget {
  const ShowInformationStatesAboutOrder({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderModel.orderStateModel.state == "inProgress"
                    ? "Done"
                    : "Recieved",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: ThemeColors.successfullyDoneColor),
              ),
              Expanded(
                child: Text(
                  " on ${formatStringIntoDateTime(orderModel.createdAt, showTotalDate: true)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const HorizontalGap(8),
        const Icon(
          Icons.arrow_forward_ios,
          size: 22,
        ),
      ],
    );
  }
}