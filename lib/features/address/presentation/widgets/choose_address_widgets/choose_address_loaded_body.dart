import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_empty_body_widget.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/address/data/models/get_orders_addresses_response_model.dart';
import 'package:e_commerce_app/features/address/data/models/orders_address_model.dart';
import 'package:e_commerce_app/features/address/presentation/cubit/addresses_cubit.dart';
import 'package:e_commerce_app/features/address/presentation/pages/add_address_page.dart';
import 'package:e_commerce_app/features/address/presentation/utils/get_user_home_address.dart';
import 'package:e_commerce_app/features/address/presentation/widgets/choose_address_widgets/show_address_details_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseAddressLoadedBody extends StatefulWidget {
  const ChooseAddressLoadedBody({
    super.key,
    required this.getOrdersAddressesResponseModel,
    required this.onAddAddressButtonPressed,
  });
  final GetOrdersAddressesResponseModel getOrdersAddressesResponseModel;
  final VoidCallback onAddAddressButtonPressed;

  @override
  State<ChooseAddressLoadedBody> createState() =>
      _ChooseAddressLoadedBodyState();
}

class _ChooseAddressLoadedBodyState extends State<ChooseAddressLoadedBody> {
  late int selectedAddress;
  late List<OrdersAddressModel> ordersAddresses = [];
  late AddressesCubit addressesCubit;
  @override
  void initState() {
    super.initState();
    addressesCubit = BlocProvider.of<AddressesCubit>(context);
    final OrdersAddressModel? userHomeAddress = getUserHomeAddress();

    // add the initial address to list of addresses
    if (userHomeAddress != null) {
      ordersAddresses.add(userHomeAddress);
    }
    // Add all other addresses from the response model
    ordersAddresses
        .addAll(widget.getOrdersAddressesResponseModel.ordersAddresses!);

    OrdersAddressModel? orderAddressChosen =
        addressesCubit.getOrderAddressChosen;
    selectedAddress = orderAddressChosen != null
        ? ordersAddresses.indexWhere((element) => orderAddressChosen == element)
        : 0;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return ordersAddresses.isEmpty
        ? const EmptyOrdersAddressesBody()
        : Column(
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
                  onPressed: widget.onAddAddressButtonPressed,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: LocalConstants.kHorizontalPadding,
                    vertical: 8,
                  ),
                  child: ListView.separated(
                    itemCount: ordersAddresses.length,
                    separatorBuilder: (context, index) => const VerticalGap(24),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAddress = index;
                        });
                      },
                      child: ShowAddressDetailsItem(
                        ordersAddressModel: ordersAddresses[index],
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
                        BlocProvider.of<AddressesCubit>(context)
                            .setOrderAddressChosen(
                                ordersAddresses[selectedAddress]);
                        Navigator.pop(context, true);
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}

class EmptyOrdersAddressesBody extends StatelessWidget {
  const EmptyOrdersAddressesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressesCubit addressesCubit =
        BlocProvider.of<AddressesCubit>(context);
    return CustomEmptyBodyWidget(
      mainLabel: "No Saved Addresses",
      subLabel:
          "You haven't added any addresses yet. Save your addresses to speed up checkout.",
      buttonDescription: "Add new addresses",
      onButtonPressed: () async {
        final isRefresh = await Navigator.pushNamed(context, AddAddressPage.id);

        if (isRefresh is bool && isRefresh == true) {
          addressesCubit.getOrdersAddresses();
        }
      },
    );
  }
}
