import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Description:",
              style: GoogleFonts.aDLaMDisplay(fontSize: 22),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          productModel.description,
          style: GoogleFonts.actor(fontSize: 20),
          overflow: TextOverflow.ellipsis,
          maxLines: 6,
        ),
      ],
    );
  }
}
