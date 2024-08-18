import 'dart:developer';

import 'package:e_commerce_app/core/helpers/functions/show_snack_bar.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/add_to_cart_service.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/update_cart_item_service.dart';
import 'package:e_commerce_app/features/products/presentation/utils/show_cart_success_modal.dart';
import 'package:flutter/material.dart';

class PriceAndCartButtonSection extends StatelessWidget {
  const PriceAndCartButtonSection({
    super.key,
    required this.productModel,
    required this.productAmount,
  });

  final ProductModel productModel;
  final int productAmount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Price",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "EGP ${productModel.price}",
              style: const TextStyle(fontSize: 30),
            ),
          ],
        ),
        CustomTriggerButton(
          buttonWidth: 220,
          buttonHeight: 50,
          description: "Add to cart",
          icon: Icons.shopping_cart,
          iconSize: 28,
          descriptionSize: 24,
          isEnabled: productAmount > 0,
          onPressed: () async {
            await addToCart(context, productModel);
          },
        ),
      ],
    );
  }

  Future<void> addToCart(
      BuildContext context, ProductModel productModel) async {
    try {
      final addToCartResponseModel = await AddToCartService.addToCart(
        productId: productModel.id,
      );
      if (addToCartResponseModel.status) {
        if (productAmount > 1) {
          final result = await UpdateCartItemService.updateCartItem(
            cartId: addToCartResponseModel.cartId!,
            newQuantity: productAmount,
          );
          if (result) {
            showCartSuccessModal(context, productModel);
          } else {
            showSnackBar(context, "Cannot add the item to the cart");
          }
        }
      } else {
        log(addToCartResponseModel.message.toString());
      }
    } catch (error) {
      showSnackBar(context, "Something went wrong. Please try again.");
      log(error.toString());
    }
  }
}
