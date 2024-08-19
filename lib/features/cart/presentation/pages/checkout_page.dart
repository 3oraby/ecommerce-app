import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_horizontal_product_item.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});
  static const id = "checkoutPage";
  @override
  Widget build(BuildContext context) {
    List<CartItemModel> cartItems =
        ModalRoute.of(context)!.settings.arguments as List<CartItemModel>;
    return Scaffold(
      backgroundColor: ThemeColors.backgroundBodiesColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Checkout",
          style: TextStyles.aDLaMDisplayBlackBold32,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Shipment",
                  style: TextStyles.aDLaMDisplayBlackBold24,
                ),
                const HorizontalGap(16),
                const Text(
                  "(1 items)",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const VerticalGap(8),
            Expanded(
              child: ListView.separated(
                itemCount: cartItems.length,
                separatorBuilder: (context, index) => const VerticalGap(16),
                itemBuilder: (context, index) => CustomHorizontalProductItem(
                  productModel: cartItems[index].product,
                  quantity: cartItems[index].quantity,
                  borderRadius: 10,
                  isLastRowEnabled: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
