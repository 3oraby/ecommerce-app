import 'dart:developer';

import 'package:e_commerce_app/core/helpers/functions/is_user_signed_in.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/address/data/models/get_all_addresses_response_model.dart';
import 'package:e_commerce_app/features/address/data/models/orders_address_model.dart';
import 'package:e_commerce_app/features/address/presentation/cubit/addresses_cubit.dart';
import 'package:e_commerce_app/features/address/presentation/utils/get_user_home_address.dart';
import 'package:e_commerce_app/features/user/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityAddressSection extends StatefulWidget {
  const CityAddressSection({
    super.key,
    required this.getAllAddressesResponseModel,
    required this.ordersAddressModel,
  });

  final GetAllAddressesResponseModel getAllAddressesResponseModel;
  final OrdersAddressModel ordersAddressModel;
  @override
  State<CityAddressSection> createState() => _CityAddressSectionState();
}

class _CityAddressSectionState extends State<CityAddressSection> {
  String? selectedValue;
  late AddressesCubit addressesCubit;
  late UserCubit userCubit;

  @override
  void initState() {
    super.initState();
    addressesCubit = BlocProvider.of<AddressesCubit>(context);
    userCubit = BlocProvider.of<UserCubit>(context);
    if (isUserSignedIn()) {
      final OrdersAddressModel? userHomeAddress = getUserHomeAddress();
      if (userHomeAddress != null) {
        log("address depends on userHomeAddress");
        selectedValue = userHomeAddress.city;
        widget.ordersAddressModel.city = userHomeAddress.city;
        widget.ordersAddressModel.addressId = userHomeAddress.addressId;
      } else {
        log("address depends on userModel");
        UserModel userModel = userCubit.getUserModel!;
        final matchingAddress =
            widget.getAllAddressesResponseModel.addresses!.firstWhere(
          (address) => address.id == userModel.addressId,
          orElse: () => widget.getAllAddressesResponseModel.addresses!.first,
        );

        selectedValue = matchingAddress.city;
        widget.ordersAddressModel.city = matchingAddress.city;
        widget.ordersAddressModel.addressId = matchingAddress.id;
      }
    } else {
      log("address depends on make new address for register");
      selectedValue = widget.getAllAddressesResponseModel.addresses!.first.city;
      userCubit.registerRequestModel.addressId =
          widget.getAllAddressesResponseModel.addresses!.first.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return DropdownButtonFormField(
      value: selectedValue,
      items: widget.getAllAddressesResponseModel.addresses!
          .map(
            (address) => DropdownMenuItem(
              value: address.city,
              child: Text(
                address.city,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (value) async {
        widget.ordersAddressModel.city = value;
        setState(() {
          selectedValue = value;
        });
        final selectedAddress =
            widget.getAllAddressesResponseModel.addresses!.firstWhere(
          (address) => address.city == value,
        );

        if (isUserSignedIn()) {
          widget.ordersAddressModel.addressId = selectedAddress.id;
          await userCubit.updateUser(
            userId: userCubit.getUserModel!.id!,
            jsonData: {
              "address_id": selectedAddress.id,
            },
          );
        } else {
          userCubit.registerRequestModel.addressId = selectedAddress.id;
        }
      },
      icon: const Icon(
        Icons.arrow_drop_down_circle,
        color: ThemeColors.primaryColor,
      ),
      decoration: const InputDecoration(
        labelText: "City",
        labelStyle: TextStyle(
          fontSize: 20,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: Icon(
          Icons.location_city,
          size: 35,
        ),
      ),
      iconSize: 35,
      menuMaxHeight: screenHeight * 0.5,
      borderRadius: BorderRadius.circular(20),
    );
  }
}
