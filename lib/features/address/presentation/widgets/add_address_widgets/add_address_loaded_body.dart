import 'dart:convert';

import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/check_connection_with_internet.dart';
import 'package:e_commerce_app/core/helpers/functions/is_user_signed_in.dart';
import 'package:e_commerce_app/core/helpers/functions/show_error_with_internet_dialog.dart';
import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/address/data/models/get_all_addresses_response_model.dart';
import 'package:e_commerce_app/features/address/data/models/orders_address_model.dart';
import 'package:e_commerce_app/features/address/presentation/cubit/addresses_cubit.dart';
import 'package:e_commerce_app/features/address/presentation/widgets/add_address_widgets/address_details_section.dart';
import 'package:e_commerce_app/features/address/presentation/widgets/add_address_widgets/city_address_section.dart';
import 'package:e_commerce_app/features/address/presentation/widgets/add_address_widgets/country_address_section.dart';
import 'package:e_commerce_app/features/auth/presentation/pages/register_page.dart';
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
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  VerticalGap(screenHeight * 0.01),
                  const CountryAddressSection(),
                  VerticalGap(screenHeight * 0.05),
                  CityAddressSection(
                    getAllAddressesResponseModel:
                        widget.getAllAddressesResponseModel,
                    ordersAddressModel: ordersAddressModel,
                  ),
                  VerticalGap(screenHeight * 0.06),
                  Visibility(
                    visible: isUserSignedIn(),
                    child: AddressDetailsSection(
                      ordersAddressModel: ordersAddressModel,
                    ),
                  ),
                ],
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
                onPressed: () async {
                  if (!await checkConnectionWithInternet()) {
                    showErrorWithInternetDialog(context);
                  } else if (!isUserSignedIn()) {
                    Navigator.pushReplacementNamed(
                      context,
                      RegisterPage.id,
                    );
                  } else if (formKey.currentState!.validate()) {
                    BlocProvider.of<AddressesCubit>(context)
                        .setOrderAddressChosen(ordersAddressModel);

                    String jsonString = jsonEncode(ordersAddressModel.toJson());

                    SharedPreferencesSingleton.setString(
                        LocalConstants.userAddressModelInPref, jsonString);
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
