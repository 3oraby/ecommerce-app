import 'package:e_commerce_app/features/orders/presentation/cubit/order_cubit.dart';
import 'package:e_commerce_app/features/orders/presentation/cubit/order_state.dart';
import 'package:e_commerce_app/features/orders/presentation/pages/tracking_order_details_page.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/my_orders_body_shimmer_loading.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/my_orders_loaded_body.dart';
import 'package:e_commerce_app/features/user/presentation/utils/get_user_stored_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersBody extends StatelessWidget {
  const MyOrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    final int userId = getUserStoredModel()!.id!;

    final OrderCubit orderCubit = BlocProvider.of<OrderCubit>(context);
    orderCubit.getAllOrders(userId);

    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is GetAllOrdersErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is GetAllOrdersLoadingState) {
          return const MyOrdersBodyShimmerLoading();
        } else if (state is GetAllOrdersLoadedState) {
          return MyOrdersLoadedBody(
            completedOrders: state.completedOrders,
            inProgressOrders: state.inProgressOrders,
            onOrderTap: (order) async {
              orderCubit.setOrderModel(order);
              final isRefresh = await Navigator.pushNamed(
                  context, TrackingOrderDetailsPage.id);
              if (isRefresh is bool && isRefresh) {
                orderCubit.getAllOrders(userId);
              }
            },
          );
        } else if (state is GetAllOrdersEmptyState) {
          return const Center(
            child: Text("you do not make any order till now"),
          );
        } else {
          return const Center(
            child: Text("no state received"),
          );
        }
      },
    );
  }
}
