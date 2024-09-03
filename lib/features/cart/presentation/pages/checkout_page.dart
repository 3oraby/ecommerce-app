import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/utils/navigation/home_page_navigation_service.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/address/presentation/pages/choose_address_page.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/checkout_page_widgets/address_selector.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/checkout_page_widgets/order_summary.dart';
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
    int totalQuantity =
        BlocProvider.of<CartCubit>(context).calculateTotalQuantity(cartItems);
    String cartPrice = BlocProvider.of<CartCubit>(context).getCartPrice;

    return Scaffold(
      backgroundColor: ThemeColors.backgroundBodiesColor,
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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: LocalConstants.kHorizontalPadding,
                vertical: 8,
              ),
              child: ListView(
                children: [
                  const AddressInfo(),
                  const VerticalGap(4),
                  AddressSelector(
                    onTap: (){}
                  ),
                  const VerticalGap(24),
                  ShipmentInfo(itemsCount: totalQuantity),
                  const VerticalGap(8),
                  CartItemsList(cartItems: cartItems),
                  const VerticalGap(24),
                  const PaymentMethod(),
                  const VerticalGap(24),
                  OrderSummary(
                    subTotal: cartPrice,
                  ),
                  const VerticalGap(24),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 0.3,
                color: Colors.grey[300]!,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: LocalConstants.kHorizontalPadding,
                vertical: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTriggerButton(
                    description: "MAKE ORDER",
                    onPressed: () {
                      //! navigate to done order page
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$totalQuantity Item",
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        "EGP $cartPrice",
                        style: TextStyles.aDLaMDisplayBlackBold24,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddressInfo extends StatelessWidget {
  const AddressInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.2,
          color: Colors.grey,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Text(
        "Address",
        style: TextStyles.aDLaMDisplayBlackBold20,
      ),
    );
  }
}

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.3,
          color: Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_rounded,
            color: Colors.grey[400],
            size: 26,
          ),
          const Spacer(flex: 1),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Cash On Delivery",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Extra charges may be applied",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
