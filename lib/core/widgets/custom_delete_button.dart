import 'dart:developer';

import 'package:e_commerce_app/core/helpers/functions/show_error_with_internet_dialog.dart';
import 'package:e_commerce_app/core/helpers/functions/show_custom_snack_bar.dart';
import 'package:e_commerce_app/core/widgets/custom_padding_decoration_button.dart';
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
          showCustomSnackBar(context, state.message);
        }
      },
      child: CustomPaddingDecorationButton(
        onTap: widget.onDeleteItemPressed,
        child: isLoading
            ? SizedBox(
                width: 28,
                height: 28,
                child: Lottie.asset(
                  "assets/animations/button_loading.json",
                ),
              )
            : const Icon(
                Icons.delete,
                color: Color.fromARGB(255, 129, 33, 24),
                size: 24,
              ),
      ),
    );
  }
}
