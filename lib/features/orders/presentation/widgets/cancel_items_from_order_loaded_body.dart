import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/show_error_with_internet_dialog.dart';
import 'package:e_commerce_app/core/helpers/functions/show_custom_snack_bar.dart';
import 'package:e_commerce_app/core/utils/navigation/home_page_navigation_service.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/orders/data/models/order_model.dart';
import 'package:e_commerce_app/features/orders/presentation/cubit/order_cubit.dart';
import 'package:e_commerce_app/features/orders/presentation/cubit/order_state.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/custom_product_details_in_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancelItemsFromOrderLoadedBody extends StatefulWidget {
  const CancelItemsFromOrderLoadedBody({
    super.key,
    required this.order,
  });
  final OrderModel order;

  @override
  State<CancelItemsFromOrderLoadedBody> createState() =>
      _CancelItemsFromOrderLoadedBodyState();
}

class _CancelItemsFromOrderLoadedBodyState
    extends State<CancelItemsFromOrderLoadedBody> {
  bool isLoading = false;
  late OrderCubit orderCubit;

  @override
  void initState() {
    super.initState();
    orderCubit = BlocProvider.of<OrderCubit>(context);
  }

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
              isItemSelectedToCancel:
                  orderCubit.isOrderItemSelectedForCancellation(
                      widget.order.orderItems[index]),
              onItemTap: () {
                setState(() {
                  orderCubit.toggleOrderItemSelectionForCancellation(
                      widget.order.orderItems[index]);
                });
              },
            ),
          ),
        ),
        BlocListener<OrderCubit, OrderState>(
          listener: (context, state) {
            if (state is CancelItemFromOrderErrorState) {
              setState(() {
                isLoading = false;
              });
              showCustomSnackBar(context, state.message);
            } else if (state is CancelItemFromOrderLoadedState) {
              setState(() {
                isLoading = false;
              });
              showCustomSnackBar(context, "Items successfully cancelled!",
                  backgroundColor: ThemeColors.successfullyDoneColor);
              orderCubit.resetSelectedItemsForCancellation();
              HomePageNavigationService.navigateToMyOrders();
              Navigator.pushNamedAndRemoveUntil(
                context,
                HomePage.id,
                (Route<dynamic> route) => false,
              );
            } else if (state is CancelItemFromOrderLoadingState) {
              setState(() {
                isLoading = true;
              });
            } else if (state is OrderNoInternetConnectionState) {
              setState(() {
                isLoading = false;
              });
              showErrorWithInternetDialog(context);
            }
          },
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.14,
            padding: LocalConstants.internalPadding,
            child: Center(
              child: CustomTriggerButton(
                backgroundColor:
                    orderCubit.getSelectedItemsCountForCancellation == 0 ||
                            isLoading
                        ? ThemeColors.unEnabledColor
                        : ThemeColors.primaryColor,
                description: orderCubit.getSelectedItemsCountForCancellation ==
                        0
                    ? "NO ITEM SELECTED"
                    : "CANCEL ${orderCubit.getSelectedItemsCountForCancellation} ITEMS",
                descriptionSize: 20,
                isEnabled: orderCubit.getSelectedItemsCountForCancellation > 0,
                buttonHeight: 55,
                onPressed: () {
                  orderCubit.cancelSelectedItems();
                },
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: ThemeColors.primaryColor,
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
