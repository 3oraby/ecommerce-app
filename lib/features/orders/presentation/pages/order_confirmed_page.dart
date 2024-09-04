import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/order_confirmed_loaded_body.dart';
import 'package:flutter/material.dart';

class OrderConfirmedPage extends StatelessWidget {
  const OrderConfirmedPage({super.key});
  static const id = "kOrderConfirmedPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundBodiesColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: const OrderConfirmedLoadedBody(),
    );
  }
}
