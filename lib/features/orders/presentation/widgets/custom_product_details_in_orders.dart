import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/get_photo_url.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_rounded_icon.dart';
import 'package:e_commerce_app/core/widgets/custom_show_product_quantity.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/orders/data/models/order_items_model.dart';
import 'package:e_commerce_app/features/orders/presentation/cubit/order_cubit.dart';
import 'package:e_commerce_app/features/reviews/constants/review_feature_constants.dart';
import 'package:e_commerce_app/features/reviews/data/models/product_review_model.dart';
import 'package:e_commerce_app/features/reviews/presentation/cubit/review_cubit.dart';
import 'package:e_commerce_app/features/reviews/presentation/pages/make_new_review_page.dart';
import 'package:e_commerce_app/features/user/presentation/cubit/user_cubit.dart';
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
    this.onEditReviewTap,
    this.productReviewModel,
  });

  final OrderItemModel orderItem;
  final EdgeInsets internalPadding;
  final bool showCancelOption;
  final bool showReviewOption;
  final bool isItemSelectedToCancel;
  final bool showQuantity;
  final void Function()? onItemTap;
  final void Function()? onEditReviewTap;
  final ProductReviewModel? productReviewModel;

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
          const VerticalGap(16),
          ShowSelectReasonForCancel(showCancelOption: showCancelOption),
          MakeReviewOption(
            showReviewOption: showReviewOption,
            orderItem: orderItem,
          ),
          if (productReviewModel != null)
            ShowEditReviewOption(
              onEditReviewTap: onEditReviewTap,
              productReviewModel: productReviewModel!,
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
              final int userId =
                  BlocProvider.of<UserCubit>(context).getUserModel!.id!;
              BlocProvider.of<OrderCubit>(context).setOrderItemModel(orderItem);
              BlocProvider.of<ReviewCubit>(context).checkUserReviewForProduct(
                productId: orderItem.product.id,
                userId: userId,
              );
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

class ShowEditReviewOption extends StatelessWidget {
  const ShowEditReviewOption({
    super.key,
    required this.onEditReviewTap,
    required this.productReviewModel,
  });
  final void Function()? onEditReviewTap;
  final ProductReviewModel productReviewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: LocalConstants.internalPadding,
      decoration: BoxDecoration(
        color: ThemeColors.actionButtonsBackgroundColor,
        borderRadius: BorderRadius.circular(LocalConstants.kBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Your feedback",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              TextButton(
                onPressed: onEditReviewTap,
                child: const Text(
                  "Edit Review",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: ThemeColors.primaryColor,
                  ),
                ),
              )
            ],
          ),
          const VerticalGap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Product rating",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: ThemeColors.mainLabelsColor,
                ),
              ),
              const HorizontalGap(16),
              CustomRoundedIcon(
                internalHorizontalPadding: 12,
                internalVerticalPadding: 6,
                backgroundColor: ReviewFeatureConstants
                    .rateReviewStates[productReviewModel.rate - 1].starColor,
                child: Row(
                  children: [
                    Text(
                      productReviewModel.rate.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const HorizontalGap(4),
                    const Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const VerticalGap(24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "review description",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: ThemeColors.mainLabelsColor,
                ),
              ),
              const HorizontalGap(8),
              Expanded(
                child: Text(
                  productReviewModel.description,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: ReviewFeatureConstants
                        .rateReviewStates[productReviewModel.rate - 1]
                        .starColor,
                  ),
                ),
              ),
            ],
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
