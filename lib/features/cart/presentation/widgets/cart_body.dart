import 'package:e_commerce_app/core/widgets/custom_horizontal_product_item.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/show_cart_service.dart';
import 'package:e_commerce_app/features/cart/data/models/show_cart_response_model.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/checkout_action_button.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/products/data/models/show_product_details_arguments_model.dart';
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
            if (data.status) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: data.cartItems!.length,
                      separatorBuilder: (context, index) =>
                          const VerticalGap(36),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ShowProductDetailsPage.id,
                            arguments: ShowProductDetailsArgumentsModel(
                              lastPageId: HomePage.id,
                              productModel: data.cartItems![index].product,
                            ),
                          );
                        },
                        child: CustomHorizontalProductItem(
                          cartItemModel: data.cartItems![index],
                          borderRadius: 10,
                        ),
                      ),
                    ),
                  ),
                  const VerticalGap(36),
                  CheckoutActionButton(
                    //! take the number from back then pass it
                    itemsNumber: 50,
                    cartItems: data.cartItems!,
                  ),
                ],
              );
            } else {
              //! no items in the cart
              return Container(
                height: 500,
                color: Colors.grey,
              );
            }
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
