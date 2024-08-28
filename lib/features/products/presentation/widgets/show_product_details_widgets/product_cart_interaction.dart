import 'dart:developer';

import 'package:e_commerce_app/core/helpers/functions/show_snack_bar.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/quantity_selector.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/add_to_cart_service.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/update_cart_item_service.dart';
import 'package:e_commerce_app/features/products/presentation/utils/show_cart_success_modal.dart';
import 'package:flutter/material.dart';

class ProductCartInteraction extends StatefulWidget {
  const ProductCartInteraction({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;

  @override
  State<ProductCartInteraction> createState() => _ProductCartInteractionState();
}

class _ProductCartInteractionState extends State<ProductCartInteraction> {
  bool showQuantity = false;
  int productAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      height: showQuantity
          ? MediaQuery.of(context).size.height * 0.25
          : MediaQuery.of(context).size.height * 0.12,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: showQuantity,
              child: QuantitySelector(
                productAmount: productAmount,
                onCancel: () {
                  setState(() {
                    showQuantity = false;
                  });
                },
                onQuantitySelected: (value) {
                  setState(() {
                    productAmount = value;
                    showQuantity = false;
                  });
                },
              ),
            ),
            const VerticalGap(16),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showQuantity = !showQuantity;
                    });
                  },
                  child: Container(
                    height: 65,
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "QTY",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "$productAmount",
                          style: TextStyles.aDLaMDisplayBlackBold24,
                        ),
                      ],
                    ),
                  ),
                ),
                const HorizontalGap(16),
                Expanded(
                  child: CustomTriggerButton(
                    buttonWidth: 220,
                    buttonHeight: 65,
                    description: "ADD TO CART",
                    backgroundColor: productAmount > 0
                        ? ThemeColors.primaryColor
                        : ThemeColors.unEnabledColor,
                    icon: Icons.shopping_cart,
                    iconSize: 28,
                    descriptionSize: 20,
                    isDescriptionBold: true,
                    isEnabled: productAmount > 0,
                    onPressed: () async {
                      await addToCart(context, widget.productModel);
                      productAmount = 0;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addToCart(
      BuildContext context, ProductModel productModel) async {
    try {
      final addToCartResponseModel = await AddToCartService().addToCart(
        productId: productModel.id,
      );
      if (addToCartResponseModel.status) {
        bool result = true;
        if (productAmount > 1) {
          result = await UpdateCartItemService().updateCartItem(
            cartId: addToCartResponseModel.cartId!,
            newQuantity: productAmount,
          );
        }
        if (result) {
          showCartSuccessModal(context, productModel);
        } else {
          showSnackBar(context, "Cannot add the item to the cart");
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
