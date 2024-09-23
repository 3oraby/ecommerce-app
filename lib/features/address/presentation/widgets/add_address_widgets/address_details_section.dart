import 'dart:developer';

import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/address/data/models/orders_address_model.dart';
import 'package:flutter/material.dart';

class AddressDetailsSection extends StatelessWidget {
  const AddressDetailsSection({
    super.key,
    required this.ordersAddressModel,
  });
  final OrdersAddressModel ordersAddressModel;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Hold up, this field is required";
        } else if (value.length < 4) {
          return "Oops! this field needs to have at least 4 characters";
        }
        return null;
      },
      onChanged: (value) => ordersAddressModel.addressInDetails = value,
      decoration: InputDecoration(
        label: const Text(
          "Additional Address Details",
          style: TextStyle(
            color: ThemeColors.unEnabledColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: ThemeColors.primaryColor,
            width: 2.0, // Thicker border
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: ThemeColors.primaryColor,
            width: 2.5, // Slightly thicker when focused
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: ThemeColors.primaryColor,
            width: 2.0,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
      ),
      maxLines: 5,
      onFieldSubmitted: (newValue) {
        log(newValue);
      },
    );
  }
}
