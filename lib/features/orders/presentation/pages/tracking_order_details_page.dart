import 'dart:developer';

import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/format_string_into_date_time.dart';
import 'package:e_commerce_app/core/helpers/functions/get_photo_url.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_rounded_icon.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/orders/data/models/order_items_model.dart';
import 'package:e_commerce_app/features/orders/data/models/order_model.dart';
import 'package:e_commerce_app/features/orders/presentation/cubit/order_cubit.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/delivery_address_details_widget.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackingOrderDetailsPage extends StatelessWidget {
  const TrackingOrderDetailsPage({super.key});
  static const String id = "kTrackingOrderDetailsPage";

  @override
  Widget build(BuildContext context) {
    final OrderModel order =
        BlocProvider.of<OrderCubit>(context).getSelectedOrderModel!;

    final bool isOrderRecieved = order.orderStateModel.state == "recieved";

    return Scaffold(
      backgroundColor: ThemeColors.backgroundBodiesColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Tracking details",
          style: TextStyles.aDLaMDisplayBlackBold24,
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: ListView(
        children: [
          const VerticalGap(6),
          ShowInformationAboutOrder(
            titleText: isOrderRecieved ? "Delivered on" : "Placed on",
            order: order,
          ),
          const VerticalGap(16),
          DeliveryAddressDetailsWidget(
            orderAddress: order.ordersAddressModel,
            internalPadding: LocalConstants.internalPadding,
          ),
          const VerticalGap(16),
          ShowReviewOption(isOrderRecieved: isOrderRecieved),
          const ShowOrderSummaryOption(),
          const VerticalGap(16),
          ItemsSummaryShipmentDetails(
            orderItems: order.orderItems,
            isOrderRecieved: isOrderRecieved,
          ),
          const VerticalGap(32),
        ],
      ),
    );
  }
}

class ItemsSummaryShipmentDetails extends StatelessWidget {
  const ItemsSummaryShipmentDetails({
    super.key,
    required this.orderItems,
    required this.isOrderRecieved,
  });
  final List<OrderItemModel> orderItems;
  final bool isOrderRecieved;

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
                visible: !isOrderRecieved,
                child: CustomTriggerButton(
                  onPressed: () {},
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
            visible: !isOrderRecieved,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.network(
                      getPhotoUrl(orderItems[index].product.photo),
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                    const HorizontalGap(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderItems[index].product.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const VerticalGap(12),
                          Text(
                            "EGP ${orderItems[index].product.price}",
                            style: const TextStyle(
                              color: ThemeColors.mainLabelsColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShowOrderSummaryOption extends StatelessWidget {
  const ShowOrderSummaryOption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        onTap: () {
          //! go to order summary page
        },
        contentPadding: LocalConstants.internalPadding,
        title: const Text(
          "View order summary",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: const Text(
          "Find shipping details here",
          style: TextStyle(
            color: ThemeColors.mainLabelsColor,
            fontSize: 16,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 20,
        ),
      ),
    );
  }
}

class ShowReviewOption extends StatelessWidget {
  const ShowReviewOption({
    super.key,
    required this.isOrderRecieved,
  });

  final bool isOrderRecieved;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isOrderRecieved,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: LocalConstants.internalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Share your experience",
                  style: TextStyle(
                    color: ThemeColors.mainLabelsColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const VerticalGap(16),
                Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(LocalConstants.kBorderRadius),
                      border: Border.all(
                        width: 0.3,
                        color: Colors.grey,
                      )),
                  padding: const EdgeInsets.all(4),
                  child: ListTile(
                    enabled: true,
                    onTap: () {
                      // ! go to add reviews page
                      log("message");
                    },
                    leading: const CustomRoundedIcon(
                      internalPadding: 10,
                      backgroundColor: ThemeColors.backgroundBodiesColor,
                      child: Icon(
                        Icons.thumb_up_rounded,
                        color: Colors.amber,
                      ),
                    ),
                    title: const Text(
                      "Review product",
                      style: TextStyle(
                        color: ThemeColors.mainLabelsColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      "Help others know what to buy",
                      style: TextStyle(
                        color: ThemeColors.mainLabelsColor,
                        fontSize: 18,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ],
            ),
          ),
          const VerticalGap(16),
        ],
      ),
    );
  }
}

class ShowInformationAboutOrder extends StatelessWidget {
  const ShowInformationAboutOrder({
    super.key,
    required this.titleText,
    required this.order,
  });

  final String titleText;
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      contentPadding: LocalConstants.internalPadding,
      leading: const CustomRoundedIcon(
        child: Icon(
          Icons.done_rounded,
          color: Colors.white,
        ),
      ),
      title: Text(
        titleText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      subtitle: Text(
        formatStringIntoDateTime(order.date, showTotalDate: true),
        style: const TextStyle(
          color: ThemeColors.mainLabelsColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
