import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';

class AddressInfo extends StatelessWidget {
  const AddressInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.2,
          color: Colors.grey,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Text(
        "Address",
        style: TextStyles.aDLaMDisplayBlackBold20,
      ),
    );
  }
}
