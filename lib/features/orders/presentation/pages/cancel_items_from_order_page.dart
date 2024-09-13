import 'package:e_commerce_app/core/helpers/functions/show_snack_bar.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';

import 'package:e_commerce_app/features/orders/data/models/order_model.dart';
import 'package:e_commerce_app/features/orders/presentation/cubit/order_cubit.dart';
import 'package:e_commerce_app/features/orders/presentation/cubit/order_state.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/cancel_items_from_order_loaded_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CancelItemsFromOrderPage extends StatefulWidget {
  const CancelItemsFromOrderPage({super.key});
  static const String id = "kCancelItemsFromOrderPage";

  @override
  State<CancelItemsFromOrderPage> createState() =>
      _CancelItemsFromOrderPageState();
}

class _CancelItemsFromOrderPageState extends State<CancelItemsFromOrderPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final OrderCubit orderCubit = BlocProvider.of<OrderCubit>(context);
    final OrderModel? order = orderCubit.getSelectedOrderModel;

    // Ensure that we return a widget even when the order is null
    if (order == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
        ),
        body: const Center(
          child: Text("No order selected"),
        ),
      );
    }

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: ThemeColors.backgroundBodiesColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            "Select items For Cancellation",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.cancel_rounded,
                size: 30,
              ),
            ),
          ],
        ),
        body: BlocListener<OrderCubit, OrderState>(
          listener: (context, state) {
            if (state is CancelItemFromOrderErrorState) {
              setState(() {
                isLoading = false;
              });
              showSnackBar(context, state.message);
            } else if (state is CancelItemFromOrderLoadedState) {
              setState(() {
                isLoading = false;
              });
              showSnackBar(context, "Items successfully cancelled!",
                  backgroundColor: Colors.green);
            } else if (state is CancelItemFromOrderLoadingState) {
              setState(() {
                isLoading = true;
              });
            }
          },
          child: CancelItemsFromOrderLoadedBody(
              orderCubit: orderCubit, order: order),
        ),
      ),
    );
  }
}
