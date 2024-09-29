import 'package:e_commerce_app/core/utils/theme/colors.dart';

import 'package:e_commerce_app/features/orders/data/models/order_model.dart';
import 'package:e_commerce_app/features/orders/presentation/cubit/order_cubit.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/cancel_items_from_order_loaded_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancelItemsFromOrderPage extends StatelessWidget {
  const CancelItemsFromOrderPage({super.key});
  static const String id = "kCancelItemsFromOrderPage";

  @override
  Widget build(BuildContext context) {
    final OrderCubit orderCubit = BlocProvider.of<OrderCubit>(context);
    final OrderModel? order = orderCubit.getSelectedOrderModel;

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

    return Scaffold(
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
              BlocProvider.of<OrderCubit>(context).resetSelectedItemsForCancellation();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.cancel_rounded,
              size: 30,
            ),
          ),
        ],
      ),
      body: CancelItemsFromOrderLoadedBody(order: order),
    );
  }
}
