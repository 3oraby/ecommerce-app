import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/widgets/custom_favorite_button.dart';
import 'package:flutter/material.dart';

class ProductTitleSection extends StatelessWidget {
  const ProductTitleSection({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            productModel.name,
            style: TextStyles.aDLaMDisplayBlackBold22,
          ),
        ),
        CustomFavoriteButton(
          productModel: productModel,
        ),
      ],
    );
  }
}
