import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/features/address/data/models/orders_address_model.dart';
import 'package:e_commerce_app/features/address/presentation/pages/choose_address_page.dart';
import 'package:e_commerce_app/features/address/presentation/utils/get_user_home_address.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:e_commerce_app/features/cart/presentation/pages/checkout_page.dart';
import 'package:flutter/material.dart';

class CheckoutActionButton extends StatelessWidget {
  const CheckoutActionButton({
    super.key,
    required this.totalQuantity,
    required this.cartItems,
    required this.cartPrice,
  });
  final int totalQuantity;
  final List<CartItemModel> cartItems;
  final String cartPrice;

  @override
  Widget build(BuildContext context) {
    return CustomTriggerButton(
      onPressed: () {
        OrdersAddressModel? userHomeAddress = getUserHomeAddress();

        Navigator.pushNamed(
          context,
          (userHomeAddress == null)
              ? ChooseAddressPage.id
              : CheckoutPage.id,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "$totalQuantity items",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "EGP $cartPrice",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const Text(
              "CHECKOUT",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(
              Icons.arrow_circle_right_rounded,
              color: Colors.white,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
