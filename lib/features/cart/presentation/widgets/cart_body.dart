import 'package:e_commerce_app/core/widgets/custom_horizontal_product_item.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/show_cart_service.dart';
import 'package:e_commerce_app/features/cart/data/models/show_cart_response_model.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/checkout_action_button.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_product_details_page.dart';
import 'package:flutter/material.dart';

class CartBody extends StatefulWidget {
  const CartBody({super.key});

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  int itemsNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: FutureBuilder(
        future: ShowCartService().showCart(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ShowCartResponseModel data = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: data.cartItems!.length,
                    separatorBuilder: (context, index) => const VerticalGap(36),
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
                ),
                CheckoutActionButton(
                  //! take the number from back then pass it
                  itemsNumber: 50,
                  cartItems: data.cartItems!,
                ),
              ],
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
    );
  }
}
