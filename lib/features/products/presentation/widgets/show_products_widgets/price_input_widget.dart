import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class PriceInputWidget extends StatelessWidget {
  const PriceInputWidget({
    super.key,
    required this.label,
    required this.onChanged,
    this.initialValue,
  });

  final String label;
  final void Function(String value) onChanged;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width -
        (2 * LocalConstants.kHorizontalPadding);

    return SizedBox(
      width: (screenWidth - 16) / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          CustomTextFormFieldWidget(
            initialValue: initialValue,
            makeBorderForTextField: false,
            fillColor: Colors.white,
            contentPadding: 8,
            hintText: "PRICE IN EGP",
            keyboardType: TextInputType.number,
            textStyle: const TextStyle(
              color: ThemeColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            hintStyle: const TextStyle(
              color: ThemeColors.subLabelsColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
