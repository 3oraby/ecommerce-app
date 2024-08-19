import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/show_cart_price_service.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:e_commerce_app/features/cart/presentation/pages/checkout_page.dart';
import 'package:flutter/material.dart';

class CheckoutActionButton extends StatelessWidget {
  const CheckoutActionButton({
    super.key,
    required this.itemsNumber,
    required this.cartItems,
  });
  final int itemsNumber;
  final List<CartItemModel> cartItems;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ShowCartPriceService.getPrice(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String cartPrice = snapshot.data!;
          return CustomTriggerButton(
            borderRadius: 15,
            borderWidth: 0,
            onPressed: () {
              Navigator.pushNamed(
                context,
                CheckoutPage.id,
                arguments: cartItems,
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
                        "$itemsNumber items",
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
        } else if (snapshot.hasError) {
          return Container(
            height: 400,
            color: Colors.red,
            child: Text(
              snapshot.error.toString(),
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          );
        } else {
          return Container(
            height: 400,
            color: Colors.amber,
          );
        }
      },
    );
  }
}
