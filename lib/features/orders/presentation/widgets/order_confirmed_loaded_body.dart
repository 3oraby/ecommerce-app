import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/utils/app_assets/images/app_images.dart';
import 'package:e_commerce_app/core/utils/navigation/home_page_navigation_service.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_horizontal_product_item.dart';
import 'package:e_commerce_app/core/widgets/custom_rounded_icon.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/address/data/models/orders_address_model.dart';
import 'package:e_commerce_app/features/address/presentation/cubit/addresses_cubit.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/delivery_address_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderConfirmedLoadedBody extends StatelessWidget {
  const OrderConfirmedLoadedBody({
    super.key,
  });

  EdgeInsets pagePadding(BuildContext context) {
    return const EdgeInsets.symmetric(
      horizontal: LocalConstants.kHorizontalPadding,
      vertical: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    final addressCubit = BlocProvider.of<AddressesCubit>(context);
    final cartCubit = BlocProvider.of<CartCubit>(context);

    OrdersAddressModel orderAddress = addressCubit.getOrderAddressChosen!;

    List<CartItemModel> cartItems = cartCubit.getCartItems;
    int totalItemsQuantity = cartCubit.getTotalItemsQuantity;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: pagePadding(context),
                  color: Colors.white,
                  child: const ConfirmedPageLabel(),
                ),
                const VerticalGap(16),
                DeliveryAddressDetailsWidget(
                  orderAddress: orderAddress,
                  internalPadding: pagePadding(context),
                ),
                const VerticalGap(16),
                Container(
                  color: Colors.white,
                  padding: pagePadding(context),
                  child: DeliveryShipmentDetailsWidget(
                    cartItems: cartItems,
                    totalItemsQuantity: totalItemsQuantity,
                  ),
                ),
                const VerticalGap(16),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: pagePadding(context),
            child: const ViewPageButtons(),
          ),
        ],
      ),
    );
  }
}

class ConfirmedPageLabel extends StatelessWidget {
  const ConfirmedPageLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(AppImages.imagesOrderConfirmed),
        const VerticalGap(16),
        const Row(
          children: [
            Text(
              "Your order has been placed",
              style: TextStyle(
                color: ThemeColors.mainLabelsColor,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            HorizontalGap(16),
            CustomRoundedIcon(
              child: Icon(
                Icons.done,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const VerticalGap(16),
        const Text(
          "Thank you for making order. Order confirmation will be sent to your email",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class ViewPageButtons extends StatelessWidget {
  const ViewPageButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTriggerButton(
          backgroundColor: Colors.white,
          borderWidth: 2,
          borderColor: ThemeColors.primaryColor,
          descriptionColor: ThemeColors.primaryColor,
          description: "VIEW ORDER",
          onPressed: () {
            HomePageNavigationService.navigateToMyOrders();
            Navigator.pushReplacementNamed(context, HomePage.id);
          },
        ),
        const VerticalGap(16),
        CustomTriggerButton(
          description: "CONTINUE SHOPPING",
          descriptionSize: 20,
          onPressed: () {
            HomePageNavigationService.navigateToHome();
            Navigator.pushReplacementNamed(context, HomePage.id);
          },
        ),
      ],
    );
  }
}

class DeliveryShipmentDetailsWidget extends StatelessWidget {
  const DeliveryShipmentDetailsWidget({
    super.key,
    required this.cartItems,
    required this.totalItemsQuantity,
  });
  final List<CartItemModel> cartItems;
  final int totalItemsQuantity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Delivery details",
          style: TextStyle(
            color: ThemeColors.mainLabelsColor,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const VerticalGap(6),
        Row(
          children: [
            const Text(
              "Shipment",
              style: TextStyle(
                color: ThemeColors.mainLabelsColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const HorizontalGap(8),
            Text(
              "($totalItemsQuantity Item)",
              style: const TextStyle(
                color: ThemeColors.subLabelsColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const VerticalGap(16),
        SizedBox(
          //! make this response able
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: cartItems.length,
            separatorBuilder: (context, index) => const VerticalDivider(
              width: 24,
              color: ThemeColors.unEnabledColor,
            ),
            itemBuilder: (context, index) => CustomHorizontalProductItem(
              cartItemModel: cartItems[index],
              borderWidth: 0,
              isLastRowEnabled: false,
            ),
          ),
        ),
      ],
    );
  }
}
