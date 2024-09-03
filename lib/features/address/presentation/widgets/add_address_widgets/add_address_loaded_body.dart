import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/address/data/models/get_all_addresses_response_model.dart';
import 'package:e_commerce_app/features/address/data/models/orders_address_model.dart';
import 'package:e_commerce_app/features/address/presentation/cubit/addresses_cubit.dart';
import 'package:e_commerce_app/features/address/presentation/widgets/add_address_widgets/address_details_section.dart';
import 'package:e_commerce_app/features/address/presentation/widgets/add_address_widgets/city_address_section.dart';
import 'package:e_commerce_app/features/address/presentation/widgets/add_address_widgets/country_address_section.dart';
import 'package:e_commerce_app/features/cart/presentation/pages/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddressLoadedBody extends StatefulWidget {
  const AddAddressLoadedBody({
    super.key,
    required this.getAllAddressesResponseModel,
  });
  final GetAllAddressesResponseModel getAllAddressesResponseModel;

  @override
  State<AddAddressLoadedBody> createState() => _AddAddressLoadedBodyState();
}

class _AddAddressLoadedBodyState extends State<AddAddressLoadedBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  OrdersAddressModel ordersAddressModel = OrdersAddressModel();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: ListView(
              children: [
                //! add phone number details
                VerticalGap(screenHeight * 0.01),
                const CountryAddressSection(),
                VerticalGap(screenHeight * 0.05),
                CityAddressSection(
                  getAllAddressesResponseModel:
                      widget.getAllAddressesResponseModel,
                  ordersAddressModel: ordersAddressModel,
                ),
                VerticalGap(screenHeight * 0.06),
                AddressDetailsSection(
                  formKey: formKey,
                  ordersAddressModel: ordersAddressModel,
                ),
              ],
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
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<AddressesCubit>(context)
                        .setUserHomeAddress(ordersAddressModel);

                    Navigator.pushReplacementNamed(
                      context,
                      CheckoutPage.id,
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
