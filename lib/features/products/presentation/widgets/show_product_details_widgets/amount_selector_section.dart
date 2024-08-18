import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_commerce_app/core/widgets/product_amount_selector.dart';

class AmountSelectorSection extends StatelessWidget {
  final int productAmount;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const AmountSelectorSection({
    super.key,
    required this.productAmount,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Choose Amount",
          style: GoogleFonts.aDLaMDisplay(
            fontSize: 20,
          ),
        ),
        ProductAmountSelector(
          productAmount: productAmount,
          onAdd: onAdd,
          onRemove: onRemove,
        ),
      ],
    );
  }
}
