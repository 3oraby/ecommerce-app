import 'package:e_commerce_app/core/widgets/custom_horizontal_product_item.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:flutter/material.dart';

class CartItemsList extends StatelessWidget {
  final List<CartItemModel> cartItems;

  const CartItemsList({required this.cartItems, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartItems.length,
      separatorBuilder: (context, index) => const VerticalGap(16),
      itemBuilder: (context, index) => CustomHorizontalProductItem(
        cartItemModel: cartItems[index],
        borderRadius: 10,
        isLastRowEnabled: false,
      ),
    );
  }
}
