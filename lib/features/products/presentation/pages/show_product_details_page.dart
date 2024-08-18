import 'dart:developer';

import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/show_snack_bar.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/add_to_cart_service.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/update_cart_item_service.dart';
import 'package:e_commerce_app/features/cart/data/models/add_to_cart_response_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowProductDetailsPage extends StatefulWidget {
  const ShowProductDetailsPage({super.key});
  static const id = "showProductDetailsPage";

  @override
  State<ShowProductDetailsPage> createState() => _ShowProductDetailsPageState();
}

class _ShowProductDetailsPageState extends State<ShowProductDetailsPage> {
  int productAmount = 0;

  @override
  Widget build(BuildContext context) {
    ProductModel productModel =
        ModalRoute.of(context)!.settings.arguments as ProductModel;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "product Details",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              //! go to cart body
            },
            icon: const Icon(
              Icons.shopping_cart,
              size: 36,
              color: ThemeColors.primaryColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                "${ApiConstants.baseUrl}${ApiConstants.getPhotoEndPoint}${productModel.photo}",
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: ThemeColors.backgroundBodiesColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Column(
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              productModel.name,
                              style: GoogleFonts.aDLaMDisplay(
                                fontSize: 22,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              //! add to favorites
                              //! change the state of the icon
                            },
                            icon: const Icon(
                              Icons.favorite_outline_outlined,
                              size: 36,
                              color: ThemeColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Description :",
                            style: GoogleFonts.aDLaMDisplay(
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Text(
                        productModel.description,
                        style: GoogleFonts.actor(
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 6,
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Choose Amount",
                            style: GoogleFonts.aDLaMDisplay(
                              fontSize: 20,
                            ),
                          ),
                          CustomTriggerButton(
                            buttonWidth: 150,
                            buttonHeight: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (productAmount > 0) {
                                        productAmount -= 1;
                                      }
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.remove_circle,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                ),
                                Text(
                                  "$productAmount",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (productAmount < 20) {
                                        productAmount += 1;
                                      }
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add_circle,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Row(
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
                              Row(
                                children: [
                                  Text(
                                    "EGP ${productModel.price}",
                                    style: const TextStyle(
                                      fontSize: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          CustomTriggerButton(
                            buttonWidth: 220,
                            buttonHeight: 50,
                            description: "add to cart",
                            icon: Icons.shopping_cart,
                            iconSize: 28,
                            descriptionSize: 24,
                            isEnabled: productAmount > 0,
                            onPressed: () async {
                              AddToCartResponseModel addToCartResponseModel =
                                  await AddToCartService.addToCart(
                                productId: productModel.id,
                              );
                              if (addToCartResponseModel.status) {
                                if (productAmount > 1) {
                                  bool result = await UpdateCartItemService
                                      .updateCartItem(
                                    cartId: addToCartResponseModel.cartId!,
                                    newQuantity: productAmount,
                                  );
                                  if (result) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: 250,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(35),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 24,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: ThemeColors
                                                            .successfullyDoneColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(200),
                                                      ),
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.done_outlined,
                                                          size: 32,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          productModel.name,
                                                          style: TextStyles
                                                              .aDLaMDisplayBlackBold22,
                                                        ),
                                                        const Text(
                                                          "Added to cart",
                                                          style: TextStyle(
                                                            color: ThemeColors
                                                                .successfullyDoneColor,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  color: ThemeColors.backgroundBodiesColor,
                                                  height: 30,
                                                  width: double.infinity,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
Text("data"),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    showSnackBar(context,
                                        "can not add the item to the cart");
                                  }
                                }
                              } else {
                                log(addToCartResponseModel.message.toString());
                              }
                            },
                          ),
                        ],
                      ),
                      const Spacer(
                        flex: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
