import 'package:e_commerce_app/core/helpers/functions/show_error_with_internet_dialog.dart';
import 'package:e_commerce_app/core/helpers/functions/show_custom_snack_bar.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_padding_decoration_button.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class MoveItemFromCartToFavoritesButton extends StatefulWidget {
  const MoveItemFromCartToFavoritesButton({
    super.key,
    required this.cartItemId,
    this.onMoveToFavoritesItemPressed,
  });

  final int cartItemId;
  final VoidCallback? onMoveToFavoritesItemPressed;

  @override
  State<MoveItemFromCartToFavoritesButton> createState() =>
      _MoveItemFromCartToFavoritesButtonState();
}

class _MoveItemFromCartToFavoritesButtonState
    extends State<MoveItemFromCartToFavoritesButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final CartCubit cartCubit = BlocProvider.of<CartCubit>(context);

    return BlocListener<CartCubit, CartState>(
      listenWhen: (previous, current) {
        return current is MoveToFavoritesLoadingState ||
            current is MoveToFavoritesErrorState ||
            current is MoveToFavoritesNoNetworkErrorState ||
            current is MoveToFavoritesLoadedState;
      },
      listener: (context, state) {
        if (state is MoveToFavoritesLoadingState) {
          if ((cartCubit.getItemsWillMoveToFavorites
              .contains(widget.cartItemId))) {
            setState(() {
              isLoading = true;
            });
          }
        } else if (state is MoveToFavoritesNoNetworkErrorState) {
          if (state.cartItemId == widget.cartItemId) {
            showErrorWithInternetDialog(context);
          }
        } else if (state is MoveToFavoritesErrorState) {
          setState(() {
            isLoading = false;
          });
          showCustomSnackBar(context, state.message);
        } else if (state is MoveToFavoritesLoadedState) {
          setState(() {
            isLoading = false;
          });
        }
      },
      child: CustomPaddingDecorationButton(
        onTap: widget.onMoveToFavoritesItemPressed,
        horizontalPadding: 4,
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Visibility(
                  visible: !isLoading,
                  maintainAnimation: true,
                  maintainInteractivity: true,
                  maintainSize: true,
                  maintainState: true,
                  child: const Text(
                    "move to favorites",
                    style: TextStyle(
                      color: ThemeColors.mainLabelsColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Visibility(
                  visible: isLoading,
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 24,
                      child:
                          Lottie.asset("assets/animations/button_loading.json"),
                    ),
                  ),
                ),
              ],
            ),
            const HorizontalGap(4),
            const Icon(
              Icons.favorite_outline_outlined,
              size: 24,
              color: ThemeColors.mainLabelsColor,
            )
          ],
        ),
      ),
    );
  }
}
