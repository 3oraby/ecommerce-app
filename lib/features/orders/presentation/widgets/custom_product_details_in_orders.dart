import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/get_photo_url.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_show_product_quantity.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/orders/data/models/order_items_model.dart';
import 'package:e_commerce_app/features/orders/presentation/cubit/order_cubit.dart';
import 'package:e_commerce_app/features/reviews/presentation/pages/make_new_review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomProductDetailsInOrders extends StatelessWidget {
  const CustomProductDetailsInOrders({
    super.key,
    required this.orderItem,
    this.internalPadding = LocalConstants.internalPadding,
    this.showCancelOption = false,
    this.isItemSelectedToCancel = false,
    this.onItemTap,
    this.showReviewOption = false,
    this.showQuantity = true,
  });

  final OrderItemModel orderItem;
  final EdgeInsets internalPadding;
  final bool showCancelOption;
  final bool showReviewOption;
  final bool isItemSelectedToCancel;
  final bool showQuantity;
  final void Function()? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: internalPadding,
      child: Column(
        children: [
          GestureDetector(
            onTap: onItemTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: showQuantity,
                      child: CustomShowProductQuantity(
                          quantity: orderItem.quantity),
                    ),
                    Image.network(
                      getPhotoUrl(orderItem.product.photo),
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ],
                ),
                const HorizontalGap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderItem.product.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const VerticalGap(12),
                      Text(
                        "EGP ${orderItem.product.price}",
                        style: const TextStyle(
                          color: ThemeColors.mainLabelsColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: showCancelOption,
                  child: Row(
                    children: [
                      const HorizontalGap(8),
                      Icon(
                        isItemSelectedToCancel
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        size: 35,
                        color: isItemSelectedToCancel
                            ? ThemeColors.primaryColor
                            : ThemeColors.unEnabledColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ShowSelectReasonForCancel(showCancelOption: showCancelOption),
          const VerticalGap(8),
          MakeReviewOption(
            showReviewOption: showReviewOption,
            orderItem: orderItem,
          ),
        ],
      ),
    );
  }
}

class MakeReviewOption extends StatelessWidget {
  const MakeReviewOption({
    super.key,
    required this.showReviewOption,
    required this.orderItem,
  });

  final bool showReviewOption;
  final OrderItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showReviewOption,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Share your experience",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          CustomTriggerButton(
            onPressed: () {
              BlocProvider.of<OrderCubit>(context).setOrderItemModel(orderItem);
              Navigator.pushNamed(context, MakeNewReviewPage.id);
            },
            description: "Review product",
            buttonWidth: 150,
            buttonHeight: 45,
            descriptionSize: 16,
            backgroundColor: ThemeColors.actionButtonsBackgroundColor,
            descriptionColor: ThemeColors.primaryColor,
          ),
        ],
      ),
    );
  }
}

class ShowSelectReasonForCancel extends StatelessWidget {
  const ShowSelectReasonForCancel({
    super.key,
    required this.showCancelOption,
  });

  final bool showCancelOption;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showCancelOption,
      child: Column(
        children: [
          const VerticalGap(32),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                builder: (context) => ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => Container(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(LocalConstants.kBorderRadius),
                border: Border.all(
                  color: ThemeColors.unEnabledColor,
                  width: 0.4,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 12,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select a Reason",
                    style: TextStyle(
                      color: ThemeColors.mainLabelsColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          const VerticalGap(16),
        ],
      ),
    );
  }
}
