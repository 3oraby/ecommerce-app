import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_product_details_widgets/product_cart_interaction.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_product_details_widgets/product_title_section.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_product_details_widgets/show_in_cart_label.dart';
import 'package:e_commerce_app/features/reviews/data/models/product_review_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowProductsDetailsLoadedBody extends StatelessWidget {
  const ShowProductsDetailsLoadedBody({
    super.key,
    required this.productModel,
    required this.inCart,
    required this.productQuantityInCart,
    required this.productReviews,
  });

  final ProductModel productModel;
  final bool inCart;
  final int? productQuantityInCart;
  final List<ProductReviewModel> productReviews;

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
                  Visibility(
                    visible: inCart,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(360),
                          ),
                          child: Center(
                            child: Text(
                              "x $productQuantityInCart",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                  const Text("Reviews:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: productReviews.length,
                    itemBuilder: (context, index) {
                      final review = productReviews[index];
                      return ListTile(
                        title: Text(review.description),
                        subtitle: Text("Rating: ${review.rate}"),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          ProductCartInteraction(
            productModel: productModel,
            productQuantityInCart: productQuantityInCart,
          ),
        ],
      ),
    );
  }
}
