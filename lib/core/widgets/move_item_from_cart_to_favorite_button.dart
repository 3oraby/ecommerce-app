
import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/show_error_with_internet_dialog.dart';
import 'package:e_commerce_app/core/helpers/functions/show_custom_snack_bar.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
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
    double screenWidth = MediaQuery.of(context).size.width -
        (2 * LocalConstants.kHorizontalPadding);

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
      child: CustomTriggerButton(
        onPressed: widget.onMoveToFavoritesItemPressed,
        buttonWidth: screenWidth * 0.5,
        buttonHeight: 40,
        borderRadius: 10,
        description: "move to favorites",
        descriptionColor: ThemeColors.mainLabelsColor,
        descriptionSize: 18,
        icon: Icons.favorite_outline_outlined,
        iconSize: 28,
        iconColor: ThemeColors.mainLabelsColor,
        backgroundColor: Colors.white,
        borderWidth: 1,
        borderColor: Colors.grey,
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Lottie.asset("assets/animations/button_loading.json"),
                  const Icon(Icons.favorite_outline_outlined)
                ],
              )
            : null,
      ),
    );
  }
}
