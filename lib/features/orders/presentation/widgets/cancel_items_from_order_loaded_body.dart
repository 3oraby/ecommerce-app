import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/utils/navigation/home_page_navigation_service.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/orders/data/models/order_model.dart';
import 'package:e_commerce_app/features/orders/presentation/cubit/order_cubit.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/custom_product_details_in_orders.dart';
import 'package:flutter/material.dart';

class CancelItemsFromOrderLoadedBody extends StatefulWidget {
  const CancelItemsFromOrderLoadedBody({
    super.key,
    required this.orderCubit,
    required this.order,
  });
  final OrderCubit orderCubit;
  final OrderModel order;

  @override
  State<CancelItemsFromOrderLoadedBody> createState() => _CancelItemsFromOrderLoadedBodyState();
}

class _CancelItemsFromOrderLoadedBodyState extends State<CancelItemsFromOrderLoadedBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VerticalGap(6),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: widget.order.orderItems.length,
            separatorBuilder: (context, index) => const VerticalGap(16),
            itemBuilder: (context, index) => CustomProductDetailsInOrders(
              orderItem: widget.order.orderItems[index],
              showCancelOption: true,
              isItemSelectedToCancel: widget.orderCubit
                  .isOrderItemSelectedForCancellation(widget.order.orderItems[index]),
              onItemTap: () {
                setState(() {
                  widget.orderCubit.toggleOrderItemSelectionForCancellation(
                      widget.order.orderItems[index]);
                });
              },
            ),
          ),
        ),
        Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.14,
          padding: LocalConstants.internalPadding,
          child: Center(
            child: CustomTriggerButton(
              backgroundColor:
                  widget.orderCubit.getSelectedItemsCountForCancellation == 0
                      ? ThemeColors.unEnabledColor
                      : ThemeColors.primaryColor,
              description: widget.orderCubit.getSelectedItemsCountForCancellation == 0
                  ? "NO ITEM SELECTED"
                  : "CANCEL ${widget.orderCubit.getSelectedItemsCountForCancellation} ITEMS",
              descriptionSize: 20,
              buttonHeight: 55,
              onPressed: () async {
                await widget.orderCubit.cancelSelectedItems();
                widget.orderCubit.resetSelectedItemsForCancellation();
                HomePageNavigationService.navigateToMyOrders();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  HomePage.id,
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
