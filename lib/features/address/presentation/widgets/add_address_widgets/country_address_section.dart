import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class CountryAddressSection extends StatelessWidget {
  const CountryAddressSection({super.key});
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: "Egypt",
      items: const [],
      onChanged: null,
      decoration: const InputDecoration(
        labelText: "Country",
        labelStyle: TextStyle(
          fontSize: 20,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: Icon(
          Icons.location_history,
          size: 35,
        ),
      ),
      icon: const Icon(
        Icons.arrow_drop_down_circle,
        color: ThemeColors.unEnabledColor,
      ),
      iconSize: 35,
      disabledHint: const Text(
        "Egypt",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
