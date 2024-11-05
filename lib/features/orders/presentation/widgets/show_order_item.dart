import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/get_photo_url.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_show_product_quantity.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/orders/data/models/order_model.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/show_information_states_about_order.dart';
import 'package:flutter/material.dart';

class ShowOrderItem extends StatelessWidget {
  const ShowOrderItem({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(LocalConstants.kBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "(${orderModel.orderItems.length}) Items: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const VerticalGap(16),
          ShowOrderItemsWidget(orderModel: orderModel),
          const VerticalGap(16),
          ShowInformationStatesAboutOrder(orderModel: orderModel),
        ],
      ),
    );
  }
}

class ShowOrderItemsWidget extends StatelessWidget {
  const ShowOrderItemsWidget({
    super.key,
    required this.orderModel,
    this.showAllDetails = true,
  });

  final OrderModel orderModel;
  final bool showAllDetails;

  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: screenHight * 0.15,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: orderModel.orderItems.length,
        itemBuilder: (context, index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomShowProductQuantity(
                    quantity: orderModel.orderItems[index].quantity),
              ],
            ),
            const VerticalGap(4),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.network(
                      getPhotoUrl(orderModel.orderItems[index].product.photo),
                      fit: BoxFit.contain,
                    ),
                  ),
                  const HorizontalGap(10),
                  Expanded(
                    flex: 2,
                    child: Visibility(
                      visible: showAllDetails,
                      child: Text(
                        orderModel.orderItems[index].product.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style: const TextStyle(
                          color: ThemeColors.mainLabelsColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
