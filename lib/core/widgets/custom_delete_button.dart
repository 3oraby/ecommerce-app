
import 'dart:developer';

import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/show_error_with_internet_dialog.dart';
import 'package:e_commerce_app/core/helpers/functions/show_snack_bar.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class CustomDeleteButton extends StatefulWidget {
  const CustomDeleteButton({
    super.key,
    required this.cartItemId,
    this.onDeleteItemPressed,
  });
  final int cartItemId;
  final VoidCallback? onDeleteItemPressed;

  @override
  State<CustomDeleteButton> createState() => _CustomDeleteButtonState();
}

class _CustomDeleteButtonState extends State<CustomDeleteButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width -
        (2 * LocalConstants.kHorizontalPadding);

    final CartCubit cartCubit = BlocProvider.of<CartCubit>(context);

    return BlocListener<CartCubit, CartState>(
      listenWhen: (previous, current) {
        return current is DeleteFromCartLoadingState ||
            current is DeleteFromCartErrorState ||
            current is DeleteCartNoNetworkErrorState;
      },
      listener: (context, state) {
        if (state is DeleteFromCartLoadingState) {
          log("items to be deleted ${cartCubit.getItemsWillBeDeleted}");

          if ((cartCubit.getItemsWillBeDeleted.contains(widget.cartItemId))) {
            setState(() {
              isLoading = true;
            });
          }
        } else if (state is DeleteCartNoNetworkErrorState) {
          log("items to be deleted ${cartCubit.getItemsWillBeDeleted}");

          if (state.cartItemId == widget.cartItemId) {
            showErrorWithInternetDialog(context);
          }
        } else if (state is DeleteFromCartErrorState) {
          setState(() {
            isLoading = false;
          });
          showSnackBar(context, state.message);
        }
      },
      child: CustomTriggerButton(
        onPressed: widget.onDeleteItemPressed,
        buttonWidth: screenWidth * 0.2,
        buttonHeight: 40,
        icon: Icons.delete,
        iconColor: const Color.fromARGB(255, 129, 33, 24),
        backgroundColor: Colors.white,
        borderWidth: 1,
        borderColor: Colors.grey,
        iconSize: 28,
        child: isLoading
            ? Lottie.asset("assets/animations/button_loading.json")
            : null,
      ),
    );
  }
}
