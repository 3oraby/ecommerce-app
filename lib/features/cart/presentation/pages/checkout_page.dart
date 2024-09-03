import 'package:e_commerce_app/core/utils/navigation/home_page_navigation_service.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/checkout_page_widgets/address_info.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/checkout_page_widgets/address_selector.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/checkout_page_widgets/shipment_info.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/checkout_page_widgets/show_cart_item_list.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});
  static const id = "checkoutPage";

  @override
  Widget build(BuildContext context) {
    List<CartItemModel> cartItems =
        BlocProvider.of<CartCubit>(context).getCartItems;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Checkout",
          style: TextStyles.aDLaMDisplayBlackBold32,
        ),
        leading: IconButton(
          onPressed: () {
            HomePageNavigationService.navigateToCart();
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomePage.id,
              (Route<dynamic> route) => false,
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: ListView(
          children: [
            const AddressInfo(),
            const VerticalGap(4),
            const AddressSelector(),
            const VerticalGap(24),
            //! get the whole quantity of the whole items
            const ShipmentInfo(itemsCount: 1),
            const VerticalGap(8),
            CartItemsList(cartItems: cartItems),
          ],
        ),
      ),
    );
  }
}
