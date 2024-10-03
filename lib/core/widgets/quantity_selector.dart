import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/show_error_with_internet_dialog.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuantitySelector extends StatefulWidget {
  const QuantitySelector({
    super.key,
    required this.onCancel,
    required this.onQuantitySelected,
    required this.productAmount,
    this.productQuantityInCart,
  });
  final ValueChanged<int> onQuantitySelected;
  final int productAmount;
  final VoidCallback onCancel;
  final int? productQuantityInCart;

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late int amountChosen;

  @override
  void initState() {
    super.initState();
    amountChosen = widget.productAmount;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listenWhen: (previous, current) {
        return current is UpdateCartNoNetworkErrorState;
      },
      listener: (context, state) {
        if (state is UpdateCartNoNetworkErrorState) {
          showErrorWithInternetDialog(context);
        }
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Quantity",
                style: TextStyles.aDLaMDisplayBlackBold22,
              ),
              IconButton(
                onPressed: widget.onCancel,
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
            ],
          ),
          const VerticalGap(16),
          SizedBox(
            height: 65,
            child: ListView.separated(
              itemCount: LocalConstants.limitProductNumberInCart -
                  (widget.productQuantityInCart ?? 0),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const HorizontalGap(16),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    amountChosen = index + 1;
                  });
                  widget.onQuantitySelected(index + 1);
                },
                child: Container(
                  height: 65,
                  width: 80,
                  decoration: BoxDecoration(
                    color: amountChosen == index + 1
                        ? Colors.white
                        : ThemeColors.actionButtonsBackgroundColor,
                    border: Border.all(
                      width: (amountChosen == index + 1) ? 2 : 1,
                      color: (amountChosen == index + 1)
                          ? ThemeColors.primaryColor
                          : Colors.grey,
                    ),
                    borderRadius:
                        BorderRadius.circular(LocalConstants.kBorderRadius),
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: TextStyles.aDLaMDisplayBlackBold24,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
