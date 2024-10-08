import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/orders/data/models/order_items_model.dart';
import 'package:e_commerce_app/features/orders/presentation/pages/cancel_items_from_order_page.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/custom_product_details_in_orders.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsSummaryShipmentDetails extends StatelessWidget {
  const ItemsSummaryShipmentDetails({
    super.key,
    required this.orderItems,
    this.showCancelOption = false,
    this.showReviewOption = false,
  });
  final List<OrderItemModel> orderItems;
  final bool showCancelOption;
  final bool showReviewOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: LocalConstants.internalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "items Summary",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Visibility(
                visible: showCancelOption,
                child: CustomTriggerButton(
                  onPressed: () {
                    Navigator.pushNamed(context, CancelItemsFromOrderPage.id);
                  },
                  backgroundColor: ThemeColors.backgroundBodiesColor,
                  borderRadius: LocalConstants.kBorderRadius,
                  description: "Cancel Items",
                  borderWidth: 0,
                  borderColor: Colors.white,
                  descriptionColor: ThemeColors.primaryColor,
                  buttonWidth: 160,
                  buttonHeight: 40,
                  descriptionSize: 18,
                ),
              ),
            ],
          ),
          const VerticalGap(10),
          Visibility(
            visible: showCancelOption,
            child: const Text(
              "Once packed ,individual items can not be cancelled",
              style: TextStyle(
                color: ThemeColors.mainLabelsColor,
                fontSize: 16,
              ),
            ),
          ),
          const VerticalGap(16),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: orderItems.length,
            separatorBuilder: (context, index) => const Divider(
              height: 56,
              color: ThemeColors.unEnabledColor,
            ),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                BlocProvider.of<ProductCatalogCubit>(context)
                    .setSelectedProduct(orderItems[index].product);
                Navigator.pushNamed(context, ShowProductDetailsPage.id);
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: CustomProductDetailsInOrders(
                  orderItem: orderItems[index],
                  showReviewOption: showReviewOption,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
