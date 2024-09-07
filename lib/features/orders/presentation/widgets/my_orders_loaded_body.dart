import 'package:e_commerce_app/features/orders/data/models/order_model.dart';
import 'package:flutter/material.dart';

class MyOrdersLoadedBody extends StatelessWidget {
  const MyOrdersLoadedBody({
    super.key,
    required this.userOrders,
  });

  final List<OrderModel> userOrders;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
