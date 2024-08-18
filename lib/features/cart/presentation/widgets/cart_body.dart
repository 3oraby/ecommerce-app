import 'package:e_commerce_app/core/widgets/custom_horizontal_product_item.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/show_cart_service.dart';
import 'package:e_commerce_app/features/cart/data/models/show_cart_response_model.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_product_details_page.dart';
import 'package:flutter/material.dart';

class CartBody extends StatelessWidget {
  const CartBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        children: [
          FutureBuilder(
            future: ShowCartService().showCart(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ShowCartResponseModel data = snapshot.data!;
                return Expanded(
                  child: ListView.separated(
                    itemCount: data.cartItems!.length,
                    separatorBuilder: (context, index) => const VerticalGap(16),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ShowProductDetailsPage.id,
                          arguments: data.cartItems![index].product,
                        );
                      },
                      child: CustomHorizontalProductItem(
                        productModel: data.cartItems![index].product,
                        quantity: data.cartItems![index].quantity,
                        borderRadius: 10,
                      ),
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
          ),
          Container(
            color: Colors.white,
            child: const CustomTriggerButton(
              borderRadius: 15,
              borderWidth: 0,
              buttonHeight: 60,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "5 items",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "EGP 1100",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "CHECKOUT",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.arrow_circle_right_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
