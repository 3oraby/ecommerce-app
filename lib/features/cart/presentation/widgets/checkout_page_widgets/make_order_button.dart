import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/show_error_with_internet_dialog.dart';
import 'package:e_commerce_app/core/helpers/functions/show_custom_snack_bar.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/features/address/presentation/cubit/addresses_cubit.dart';
import 'package:e_commerce_app/features/orders/data/models/checkout_request_model.dart';
import 'package:e_commerce_app/features/orders/presentation/cubit/order_cubit.dart';
import 'package:e_commerce_app/features/orders/presentation/cubit/order_state.dart';
import 'package:e_commerce_app/features/orders/presentation/pages/order_confirmed_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MakeOrderButton extends StatefulWidget {
  const MakeOrderButton({
    super.key,
    required this.cartPrice,
    required this.totalQuantity,
  });

  final int totalQuantity;
  final String cartPrice;
  @override
  State<MakeOrderButton> createState() => _MakeOrderButtonState();
}

class _MakeOrderButtonState extends State<MakeOrderButton> {
  bool isMakeOrderLoading = false;

  void makeOrderTap(BuildContext context) async {
    final addressesCubit = BlocProvider.of<AddressesCubit>(context);
    final orderCubit = BlocProvider.of<OrderCubit>(context);
    CheckoutRequestModel checkoutRequestModel = CheckoutRequestModel(
      addressInDetails: addressesCubit.getOrderAddressChosen!.addressInDetails,
    );
    await orderCubit.confirmOrder(jsonData: checkoutRequestModel.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is MakeOrderLoadingState) {
          setState(() {
            isMakeOrderLoading = true;
          });
        } else if (state is MakeOrderLoadedState) {
          setState(() {
            isMakeOrderLoading = false;
          });
          Navigator.pushNamedAndRemoveUntil(
            context,
            OrderConfirmedPage.id,
            (Route<dynamic> route) => false,
          );
        } else if (state is MakeOrderErrorState) {
          setState(() {
            isMakeOrderLoading = false;
          });
          showCustomSnackBar(context, state.message);
        } else if (state is OrderNoInternetConnectionState) {
          setState(() {
            isMakeOrderLoading = false;
          });
          showErrorWithInternetDialog(context);
        }
      },
      child: Container(
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
                backgroundColor: isMakeOrderLoading
                    ? ThemeColors.unEnabledButtonsColor
                    : ThemeColors.primaryColor,
                child: isMakeOrderLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: ThemeColors.primaryColor,
                        ),
                      )
                    : null,
                onPressed: () => makeOrderTap(context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.totalQuantity} Item",
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    "EGP ${widget.cartPrice}",
                    style: TextStyles.aDLaMDisplayBlackBold24,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
