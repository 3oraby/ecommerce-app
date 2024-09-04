import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_horizontal_product_item.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/address/data/models/orders_address_model.dart';
import 'package:e_commerce_app/features/address/presentation/cubit/addresses_cubit.dart';
import 'package:e_commerce_app/features/address/presentation/widgets/choose_address_widgets/show_address_details_item.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
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

    OrdersAddressModel orderAddress =
        addressCubit.getOrderAddressChosen ?? addressCubit.getUserHomeAddress!;

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
                Container(
                  color: Colors.white,
                  padding: pagePadding(context),
                  child: DeliveryAddressDetailsWidget(
                    orderAddress: orderAddress,
                  ),
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
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Your order has been placed",
          style: TextStyle(
            color: ThemeColors.mainLabelsColor,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        VerticalGap(8),
        Text(
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
          onPressed: () {},
        ),
        const VerticalGap(16),
        CustomTriggerButton(
          description: "CONTINUE SHOPPING",
          descriptionSize: 20,
          onPressed: () {},
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
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: cartItems.length,
            separatorBuilder: (context, index) => const HorizontalGap(16),
            itemBuilder: (context, index) => CustomHorizontalProductItem(
              cartItemModel: cartItems[index],
              width: 400,
              borderWidth: 0,
              isLastRowEnabled: false,
            ),
          ),
        ),
      ],
    );
  }
}

class DeliveryAddressDetailsWidget extends StatelessWidget {
  const DeliveryAddressDetailsWidget({
    super.key,
    required this.orderAddress,
  });
  final OrdersAddressModel orderAddress;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              "Delivery address",
              style: TextStyle(
                color: ThemeColors.mainLabelsColor,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            HorizontalGap(6),
            Text(
              "(Home)",
              style: TextStyle(
                color: ThemeColors.subLabelsColor,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const VerticalGap(10),
        ShowAddressDetailsItem(
          ordersAddressModel: orderAddress,
          isSelectedAddress: false,
          normalBorderWidth: 0,
          showFirstLine: false,
          internalPadding: false,
        ),
      ],
    );
  }
}
