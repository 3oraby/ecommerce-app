import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
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
        IconButton(
          onPressed: () {
            //! Add to favorites
            //! Change the state of the icon
          },
          icon: const Icon(
            Icons.favorite_outline_outlined,
            size: 36,
            color: ThemeColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
