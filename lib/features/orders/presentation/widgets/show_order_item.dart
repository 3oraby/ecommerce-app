import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/format_string_into_date_time.dart';
import 'package:e_commerce_app/core/helpers/functions/get_photo_url.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_show_product_quantity.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/orders/data/models/order_model.dart';
import 'package:flutter/material.dart';

class ShowOrderItem extends StatelessWidget {
  const ShowOrderItem({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.3,
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
          ShowOrderItemsWidget(
            screenHeight: screenHeight,
            orderModel: orderModel,
          ),
          const VerticalGap(24),
          ShowInformationAboutOrder(orderModel: orderModel),
        ],
      ),
    );
  }
}

class ShowInformationAboutOrder extends StatelessWidget {
  const ShowInformationAboutOrder({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderModel.orderStateModel.state == "inProgress"
                    ? "Done"
                    : "Recieved",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: ThemeColors.successfullyDoneColor),
              ),
              Expanded(
                child: Text(
                  " on ${formatStringIntoDateTime(orderModel.date, showTotalDate: true)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const HorizontalGap(8),
        const Icon(
          Icons.arrow_forward_ios,
          size: 22,
        ),
      ],
    );
  }
}

class ShowOrderItemsWidget extends StatelessWidget {
  const ShowOrderItemsWidget({
    super.key,
    required this.screenHeight,
    required this.orderModel,
    this.showAllDetails = true,
  });

  final double screenHeight;
  final OrderModel orderModel;
  final bool showAllDetails;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.15,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: orderModel.orderItems.length,
        itemBuilder: (context, index) => SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomShowProductQuantity(
                    quantity: orderModel.orderItems[index].quantity,
                  ),
                ],
              ),
              const VerticalGap(4),
              Expanded(
                child: Row(
                  children: [
                    Image.network(
                      fit: BoxFit.contain,
                      getPhotoUrl(
                        orderModel.orderItems[index].product.photo,
                      ),
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                    const HorizontalGap(10),
                    Expanded(
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
      ),
    );
  }
}
