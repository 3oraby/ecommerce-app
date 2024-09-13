import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/format_string_into_date_time.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/show_order_summary_widget.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/orders/data/models/order_model.dart';
import 'package:e_commerce_app/features/orders/presentation/cubit/order_cubit.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/delivery_address_details_widget.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/items_summary_shipment_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowOrderSummaryPage extends StatelessWidget {
  const ShowOrderSummaryPage({super.key});

  static const String id = "kShowOrderSummaryPage";

  @override
  Widget build(BuildContext context) {
    final OrderModel orderModel =
        BlocProvider.of<OrderCubit>(context).getSelectedOrderModel!;

    return Scaffold(
      backgroundColor: ThemeColors.backgroundBodiesColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Order summary",
          style: TextStyles.aDLaMDisplayBlackBold26,
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          const VerticalGap(8),
          Center(
            child: Text(
              "Placed On ${formatStringIntoDateTime(
                orderModel.date,
                showTotalDate: true,
              )}",
              style: const TextStyle(
                color: ThemeColors.mainLabelsColor,
                fontSize: 18,
              ),
            ),
          ),
          const VerticalGap(16),
          ShowOrderSummaryWidget(
            subTotal: orderModel.total.toString(),
            showPaymentSection: true,
          ),
          const VerticalGap(16),
          DeliveryAddressDetailsWidget(
            orderAddress: orderModel.ordersAddressModel,
            internalPadding: LocalConstants.internalPadding,
          ),
          const VerticalGap(16),
          ItemsSummaryShipmentDetails(
            orderItems: orderModel.orderItems,
          ),
          const VerticalGap(32),
        ],
      ),
    );
  }
}
