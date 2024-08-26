import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/address/data/models/get_all_addresses_response_model.dart';
import 'package:e_commerce_app/features/address/data/models/save_user_address_model.dart';
import 'package:flutter/material.dart';

class CityAddressSection extends StatefulWidget {
  const CityAddressSection({
    super.key,
    required this.getAllAddressesResponseModel,
    required this.saveUserAddressModel,
  });

  final GetAllAddressesResponseModel getAllAddressesResponseModel;
  final SaveUserAddressModel saveUserAddressModel;
  @override
  State<CityAddressSection> createState() => _CityAddressSectionState();
}

class _CityAddressSectionState extends State<CityAddressSection> {
  String? selectedValue;
  @override
  void initState() {
    super.initState();
    selectedValue = widget.getAllAddressesResponseModel.addresses!.first.city;
    widget.saveUserAddressModel.city =
        widget.getAllAddressesResponseModel.addresses!.first.city;

    widget.saveUserAddressModel.id =
        widget.getAllAddressesResponseModel.addresses!.first.id;
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
      onChanged: (value) {
        widget.saveUserAddressModel.city = value;
        setState(() {
          selectedValue = value;
        });
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
      menuMaxHeight: screenHeight / 2,
      borderRadius: BorderRadius.circular(20),
    );
  }
}
