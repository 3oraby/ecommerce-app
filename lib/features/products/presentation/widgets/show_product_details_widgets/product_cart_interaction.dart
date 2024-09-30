import 'dart:developer';

import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/is_user_signed_in.dart';
import 'package:e_commerce_app/core/helpers/functions/show_error_with_internet_dialog.dart';
import 'package:e_commerce_app/core/helpers/functions/show_not_signed_in_dialog.dart';
import 'package:e_commerce_app/core/helpers/functions/show_custom_snack_bar.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/quantity_selector.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_state.dart';
import 'package:e_commerce_app/features/products/presentation/utils/show_cart_success_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCartInteraction extends StatefulWidget {
  const ProductCartInteraction({
    super.key,
    required this.productModel,
    this.productQuantityInCart,
  });
  final ProductModel productModel;
  final int? productQuantityInCart;
  @override
  State<ProductCartInteraction> createState() => _ProductCartInteractionState();
}
class _ProductCartInteractionState extends State<ProductCartInteraction> {
  bool showQuantity = false;
  late int productAmount;
  late bool isMaxQuantity;
  late CartCubit cartCubit;
  bool isAddToCartLoading = false;

  @override
  void initState() {
    super.initState();
    isMaxQuantity = (widget.productQuantityInCart ?? 0) == LocalConstants.limitProductNumberInCart;
    productAmount = isMaxQuantity ? LocalConstants.limitProductNumberInCart : 1;
    cartCubit = BlocProvider.of<CartCubit>(context);
  }

  Future<void> addProductToCart(BuildContext context, int productId, int quantity) async {
    try {
      await cartCubit.updateCartItem(
        productId: productId,
        quantity: quantity + (widget.productQuantityInCart ?? 0),
      );
    } catch (error) {
      if (mounted) {
        showCustomSnackBar(context, "Something went wrong. Please try again.");
      }
      log(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      height: showQuantity ? MediaQuery.of(context).size.height * 0.25 : MediaQuery.of(context).size.height * 0.12,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: showQuantity,
              child: QuantitySelector(
                productAmount: productAmount,
                productQuantityInCart: widget.productQuantityInCart,
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
                    if (!isMaxQuantity) {
                      setState(() {
                        showQuantity = !showQuantity;
                      });
                    }
                  },
                  child: Container(
                    height: 65,
                    width: 80,
                    decoration: BoxDecoration(
                      color: isMaxQuantity ? ThemeColors.unEnabledColor : Colors.white,
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("QTY", style: TextStyle(fontSize: 16)),
                        Text("$productAmount", style: TextStyles.aDLaMDisplayBlackBold24),
                      ],
                    ),
                  ),
                ),
                const HorizontalGap(16),
                BlocListener<CartCubit, CartState>(
                  listener: (context, state) {
                    if (state is CartItemUpdatedLoadingState) {
                      if (mounted) {
                        setState(() {
                          isAddToCartLoading = true;
                        });
                      }
                    } else if (state is CartItemUpdatedErrorState) {
                      if (mounted) {
                        showCustomSnackBar(context, state.message);
                        setState(() {
                          isAddToCartLoading = false;
                        });
                      }
                    } else if (state is CartItemUpdatedLoadedState) {
                      if (mounted) {
                        setState(() {
                          isAddToCartLoading = false;
                        });
                      }
                      cartCubit.loadCartPrice().then((cartPrice) {
                        if (mounted) {
                          cartCubit.refreshPage();
                          showCartSuccessModal(
                            context: context,
                            productModel: widget.productModel,
                            cartPrice: cartPrice,
                          );
                        }
                      });
                    }else if (state is UpdateCartNoNetworkErrorState){
                      if (mounted){
                        setState(() {
                          productAmount = 1;
                        });
                      }
                      showErrorWithInternetDialog(context);
                    }
                  },
                  child: Expanded(
                    child: CustomTriggerButton(
                      buttonWidth: 220,
                      buttonHeight: 65,
                      backgroundColor: isMaxQuantity || isAddToCartLoading
                          ? ThemeColors.unEnabledColor 
                          : ThemeColors.primaryColor,
                      onPressed: () async {
                        if (!isUserSignedIn()){
                          showNotSignedInDialog(context);
                        }
                        else if (!isMaxQuantity) {
                          await addProductToCart(
                            context,
                            widget.productModel.id,
                            productAmount,
                          );
                          if (mounted) {
                            setState(() {
                              productAmount = 0;
                            });
                          }
                        }
                      },
                      child: isAddToCartLoading
                          ? const Center(
                              child: CircularProgressIndicator(color: ThemeColors.primaryColor),
                            )
                          : Column(
                              mainAxisAlignment: isMaxQuantity ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
                              children: [
                                const Row(
                                  children: [
                                    Spacer(flex: 4),
                                    Text("ADD TO CART", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                                    Spacer(flex: 1),
                                    Icon(Icons.shopping_cart, size: 28, color: Colors.white),
                                    Spacer(flex: 4),
                                  ],
                                ),
                                Visibility(
                                  visible: isMaxQuantity,
                                  child: const Text("Max quantity already in cart", style: TextStyle(fontSize: 16)),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
