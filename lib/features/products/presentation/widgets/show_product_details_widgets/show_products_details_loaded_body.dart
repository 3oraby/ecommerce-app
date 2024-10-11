import 'dart:developer';

import 'package:e_commerce_app/core/helpers/functions/get_photo_url.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/app_assets/images/app_images.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/show_all_reviews_widget.dart';
import 'package:e_commerce_app/core/widgets/show_product_average_rating.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_product_details_widgets/product_cart_interaction.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_product_details_widgets/product_title_section.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_product_details_widgets/show_in_cart_label.dart';
import 'package:e_commerce_app/features/reviews/data/models/product_review_model.dart';
import 'package:e_commerce_app/features/reviews/presentation/pages/show_all_reviews_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowProductsDetailsLoadedBody extends StatelessWidget {
  const ShowProductsDetailsLoadedBody({
    super.key,
    required this.productModel,
    required this.inCart,
    this.productQuantityInCart,
    required this.productReviews,
    required this.averageRating,
  });

  final ProductModel productModel;
  final bool inCart;
  final int? productQuantityInCart;
  final List<ProductReviewModel> productReviews;
  final String? averageRating;

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
                  ShowProductQuantityInCart(
                    inCart: inCart,
                    productQuantityInCart: productQuantityInCart,
                  ),
                  const VerticalGap(16),
                  Text(
                    productModel.description,
                    style: GoogleFonts.actor(
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 6,
                  ),
                  const VerticalGap(24),
                  Image.network(
                    getPhotoUrl(productModel.photo),
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.3,
                    fit: BoxFit.contain,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      log(getPhotoUrl(productModel.photo));
                      return Image.asset(AppImages.imagesNotDownloaded);
                    },
                  ),
                  const VerticalGap(36),
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
                  const VerticalGap(48),
                  if (averageRating != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShowAverageRating(
                          averageRating: averageRating!,
                          enablePadding: false,
                        ),
                        const VerticalGap(24),
                        const Divider(),
                        const VerticalGap(24),
                        ShowAllReviews(
                          productReviews: productReviews,
                          showTotalReviews: false,
                          enablePadding: false,
                        ),
                        Visibility(
                          visible: productReviews.length > 3,
                          child: Column(
                            children: [
                              const Divider(
                                height: 36,
                              ),
                              CustomTriggerButton(
                                backgroundColor: Colors.white,
                                borderColor: ThemeColors.primaryColor,
                                borderWidth: 2,
                                description: "VIEW MORE",
                                descriptionSize: 20,
                                descriptionColor: ThemeColors.primaryColor,
                                buttonHeight: 50,
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, ShowAllReviewsPage.id);
                                },
                              ),
                            ],
                          ),
                        ),
                        const VerticalGap(48),
                      ],
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

class ShowProductQuantityInCart extends StatelessWidget {
  const ShowProductQuantityInCart({
    super.key,
    required this.inCart,
    required this.productQuantityInCart,
  });

  final bool inCart;
  final int? productQuantityInCart;

  @override
  Widget build(BuildContext context) {
    return Visibility(
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
    );
  }
}
