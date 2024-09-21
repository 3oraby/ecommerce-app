import 'package:e_commerce_app/core/helpers/functions/get_photo_url.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/widgets/custom_favorite_button.dart';
import 'package:e_commerce_app/core/widgets/custom_rounded_image_container.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:flutter/material.dart';

class CustomMainProductCard extends StatelessWidget {
  const CustomMainProductCard({
    super.key,
    required this.productModel,
    this.backgroundColor = Colors.white,
    this.borderRadius = 20,
    this.isFavoritePage = false,
  });

  final ProductModel productModel;
  final Color backgroundColor;
  final double borderRadius;
  final bool isFavoritePage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
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
              imagePath: getPhotoUrl(productModel.photo),
              height: MediaQuery.of(context).size.height * 0.2,
              fit: BoxFit.contain,
            ),
            const VerticalGap(24),
            Expanded(
              child: Text(
                productModel.name,
                textAlign: TextAlign.center,
                style: TextStyles.aDLaMDisplayBlackBold20,
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
                  style: TextStyles.aDLaMDisplayBlackBold22,
                ),
                CustomFavoriteButton(
                  productModel: productModel,
                  isFavoritePage: isFavoritePage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
