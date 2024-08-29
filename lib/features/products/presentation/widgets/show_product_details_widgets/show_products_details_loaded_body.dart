import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_product_details_widgets/product_cart_interaction.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_product_details_widgets/product_title_section.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_product_details_widgets/show_in_cart_label.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowProductsDetailsLoadedBody extends StatelessWidget {
  const ShowProductsDetailsLoadedBody({
    super.key,
    required this.productModel,
    required this.inCart,
  });

  final ProductModel productModel;
  final bool inCart;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8,
              ),
              child: ListView(
                children: [
                  const VerticalGap(16),
                  ProductTitleSection(productModel: productModel),
                  const VerticalGap(16),
                  ShowInCartLabel(
                    inCart: inCart,
                  ),
                  const VerticalGap(16),
                  // description section
                  Text(
                    productModel.description,
                    style: GoogleFonts.actor(
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 6,
                  ),
                  const VerticalGap(24),
                  // image section
                  Image.network(
                    "${ApiConstants.baseUrl}${ApiConstants.getPhotoEndPoint}${productModel.photo}",
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.3,
                    fit: BoxFit.contain,
                  ),
                  const VerticalGap(36),
                  // price section
                  Row(
                    children: [
                      const Text(
                        "EGP",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      const HorizontalGap(8),
                      Text(
                        "${productModel.price}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const VerticalGap(16),
                  const Row(
                    children: [
                      Icon(
                        Icons.flash_on,
                        color: ThemeColors.successfullyDoneColor,
                        size: 30,
                      ),
                      HorizontalGap(4),
                      Text(
                        "Selling out fast",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ProductCartInteraction(
            productModel: productModel,
          ),
        ],
      ),
    );
  }
}
