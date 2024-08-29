import 'package:e_commerce_app/core/widgets/custom_horizontal_product_item.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/cart/data/models/show_cart_response_model.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/checkout_action_button.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/products/data/models/show_product_details_arguments_model.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_product_details_page.dart';
import 'package:flutter/widgets.dart';

class CartBodyLoaded extends StatelessWidget {
  const CartBodyLoaded({
    super.key,
    required this.showCartResponseModel,
    required this.cartPrice,
    required this.totalQuantity,
  });

  final ShowCartResponseModel showCartResponseModel;
  final String cartPrice;
  final int totalQuantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: showCartResponseModel.cartItems!.length,
              separatorBuilder: (context, index) => const VerticalGap(36),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ShowProductDetailsPage.id,
                    arguments: ShowProductDetailsArgumentsModel(
                      lastPageId: HomePage.id,
                      productModel:
                          showCartResponseModel.cartItems![index].product,
                    ),
                  );
                },
                child: CustomHorizontalProductItem(
                  cartItemModel: showCartResponseModel.cartItems![index],
                ),
              ),
            ),
          ),
          const VerticalGap(36),
          CheckoutActionButton(
            totalQuantity: totalQuantity,
            cartItems: showCartResponseModel.cartItems!,
            cartPrice: cartPrice,
          ),
        ],
      ),
    );
  }
}
