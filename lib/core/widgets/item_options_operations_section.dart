import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/widgets/custom_delete_button.dart';
import 'package:e_commerce_app/core/widgets/custom_padding_decoration_button.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/move_item_from_cart_to_favorite_button.dart';
import 'package:e_commerce_app/core/widgets/quantity_selector.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ItemOptionsOperationsSection extends StatefulWidget {
  const ItemOptionsOperationsSection({
    super.key,
    required this.onQuantitySelected,
    required this.productAmount,
    required this.cartItemId,
    this.onDeleteItemPressed,
    this.onMoveToFavoritesItemPressed,
  });
  final VoidCallback? onDeleteItemPressed;
  final VoidCallback? onMoveToFavoritesItemPressed;
  final ValueChanged<int> onQuantitySelected;
  final int productAmount;
  final int cartItemId;

  @override
  State<ItemOptionsOperationsSection> createState() =>
      _ItemOptionsOperationsSectionState();
}

class _ItemOptionsOperationsSectionState
    extends State<ItemOptionsOperationsSection> {
  bool showQuantity = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VerticalGap(16),
        SizedBox(
          height: 44,
          child: Row(
            children: [
              BlocBuilder<CartCubit, CartState>(
                buildWhen: (previous, current) {
                  return current is CartItemUpdatedErrorState ||
                      current is CartItemUpdatedLoadingState ||
                      current is CartItemUpdatedLoadedState;
                },
                builder: (context, state) => CustomPaddingDecorationButton(
                  horizontalPadding: 12,
                  onTap: () {
                    setState(() {
                      showQuantity = !showQuantity;
                    });
                  },
                  child: Row(
                    children: [
                      state is CartItemUpdatedLoadingState &&
                              state.cartId == widget.cartItemId
                          ? SizedBox(
                              height: 24,
                              child: Lottie.asset(
                                  "assets/animations/button_loading.json"),
                            )
                          : Text(
                              "${widget.productAmount}",
                              style: TextStyles.aDLaMDisplayBlackBold18,
                            ),
                      const HorizontalGap(4),
                      const Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
              CustomDeleteButton(
                onDeleteItemPressed: widget.onDeleteItemPressed,
                cartItemId: widget.cartItemId,
              ),
              const Spacer(flex: 4),
              MoveItemFromCartToFavoritesButton(
                cartItemId: widget.cartItemId,
                onMoveToFavoritesItemPressed:
                    widget.onMoveToFavoritesItemPressed,
              ),
            ],
          ),
        ),
        Visibility(
          visible: showQuantity,
          child: QuantitySelector(
              productAmount: widget.productAmount,
              onCancel: () {
                setState(() {
                  showQuantity = false;
                });
              },
              onQuantitySelected: (value) {
                setState(() {
                  showQuantity = false;
                });
                widget.onQuantitySelected(value);
              }),
        ),
      ],
    );
  }
}
