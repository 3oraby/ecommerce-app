import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/address/data/models/get_orders_addresses_response_model.dart';
import 'package:e_commerce_app/features/address/presentation/pages/add_address_page.dart';
import 'package:e_commerce_app/features/address/presentation/widgets/choose_address_widgets/show_address_details_item.dart';
import 'package:flutter/material.dart';

class ChooseAddressLoadedBody extends StatefulWidget {
  const ChooseAddressLoadedBody({
    super.key,
    required this.getOrdersAddressesResponseModel,
  });
  final GetOrdersAddressesResponseModel getOrdersAddressesResponseModel;

  @override
  State<ChooseAddressLoadedBody> createState() =>
      _ChooseAddressLoadedBodyState();
}

class _ChooseAddressLoadedBodyState extends State<ChooseAddressLoadedBody> {
  int selectedAddress = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: CustomTriggerButton(
            buttonHeight: screenHeight * 0.06,
            backgroundColor: ThemeColors.backgroundBodiesColor,
            borderWidth: 2,
            borderColor: ThemeColors.primaryColor,
            description: "ADD A NEW ADDRESS",
            descriptionColor: ThemeColors.primaryColor,
            descriptionSize: 18,
            onPressed: () {
              Navigator.pushNamed(context, AddAddressPage.id);
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: LocalConstants.kHorizontalPadding, vertical: 8),
            child: ListView.separated(
              itemCount: widget
                  .getOrdersAddressesResponseModel.ordersAddresses!.length,
              separatorBuilder: (context, index) => const VerticalGap(24),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAddress = index;
                  });
                },
                child: ShowAddressDetailsItem(
                  ordersAddressModel: widget
                      .getOrdersAddressesResponseModel.ordersAddresses![index],
                  isSelectedAddress: selectedAddress == index,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: screenHeight / 9,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTriggerButton(
                description: "CONFIRM",
                descriptionSize: 24,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
