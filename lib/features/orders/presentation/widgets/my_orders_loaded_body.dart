import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/orders/data/models/order_model.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/show_order_item.dart';
import 'package:flutter/material.dart';

class MyOrdersLoadedBody extends StatelessWidget {
  const MyOrdersLoadedBody({
    super.key,
    required this.completedOrders,
    required this.inProgressOrders,
  });

  final List<OrderModel> completedOrders;
  final List<OrderModel> inProgressOrders;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: LocalConstants.kHorizontalPadding,
        vertical: 8,
      ),
      child: ListView(
        children: [
          OrderSection(
            title: "InProgress",
            orders: inProgressOrders,
          ),
          OrderSection(
            title: "Completed",
            orders: completedOrders,
          ),
        ],
      ),
    );
  }
}

class OrderSection extends StatelessWidget {
  const OrderSection({
    super.key,
    required this.title,
    required this.orders,
  });

  final String title;
  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 26,
                color: ThemeColors.mainLabelsColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const HorizontalGap(8),
            Text(
              "(${orders.length} Orders)",
              style: const TextStyle(
                color: ThemeColors.subLabelsColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const VerticalGap(8),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: orders.length,
          separatorBuilder: (context, index) => const VerticalGap(16),
          itemBuilder: (context, index) => ShowOrderItem(
            orderModel: orders[index],
          ),
        ),
        const VerticalGap(48),
      ],
    );
  }
}
