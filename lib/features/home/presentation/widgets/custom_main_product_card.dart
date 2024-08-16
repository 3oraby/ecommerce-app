import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/widgets/custom_rounded_image_container.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomMainProductCard extends StatelessWidget {
  const CustomMainProductCard({
    super.key,
    required this.productModel,
    this.backgroundColor = Colors.white,
    this.borderRadius = 30,
    this.height = 350,
    this.width = double.infinity,
  });

  final ProductModel productModel;
  final Color backgroundColor;
  final double borderRadius;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16,
          bottom: 24,
          left: 8,
          right: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomRoundedImageContainer(
              imagePath: "${ApiConstants.baseUrl}${ApiConstants.getPhotoEndPoint}${productModel.photo}",
              height: 200,
              fit: BoxFit.contain,
            ),
            const VerticalGap(24),
            Expanded(
              child: Text(
                productModel.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.aDLaMDisplay(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            const VerticalGap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  productModel.price.toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.aDLaMDisplay(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    //! add to favorites
                    //! change the state of the icon
                  },
                  icon: const Icon(
                    Icons.favorite_outline_outlined,
                    size: 36,
                    color: ThemeColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
