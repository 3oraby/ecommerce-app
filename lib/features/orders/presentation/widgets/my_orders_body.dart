
import 'package:e_commerce_app/features/orders/presentation/cubit/order_cubit.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/my_orders_loaded_body.dart';
import 'package:e_commerce_app/features/user/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersBody extends StatelessWidget {
  const MyOrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    final int userId = BlocProvider.of<UserCubit>(context).userModel!.id!;

    final OrderCubit orderCubit = BlocProvider.of<OrderCubit>(context);
    orderCubit.getAllOrders(userId);

    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is GetAllOrdersErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is GetAllOrdersLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetAllOrdersLoadedState) {
          return MyOrdersLoadedBody(userOrders: state.userOrders);
        } else {
          return const Center(
            child: Text("you do not make any order till now"),
          );
        }
      },
    );
  }
}
