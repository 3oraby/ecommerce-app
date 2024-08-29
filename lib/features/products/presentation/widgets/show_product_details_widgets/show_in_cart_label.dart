import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class ShowInCartLabel extends StatelessWidget {
  const ShowInCartLabel({
    super.key,
    required this.inCart,
  });
  final bool inCart;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: inCart,
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          height: 40,
          width: 130,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ThemeColors.successfullyDoneColor,
            borderRadius: BorderRadius.circular(60),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "In Your Cart",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.save_alt_outlined,
                size: 20,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
