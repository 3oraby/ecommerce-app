import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/utils/navigation/home_page_navigation_service.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/products/data/data_sources/check_product_in_cart_service.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_product_details_widgets/product_cart_interaction.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_product_details_widgets/product_title_section.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowProductDetailsPage extends StatelessWidget {
  const ShowProductDetailsPage({super.key});
  static const id = "showProductDetailsPage";

  @override
  Widget build(BuildContext context) {
    ProductModel productModel =
        ModalRoute.of(context)!.settings.arguments as ProductModel;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "product Details",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              HomePageNavigationService.navigateToCart();
              Navigator.pushNamedAndRemoveUntil(
                context,
                HomePage.id,
                (Route<dynamic> route) => false,
              );
            },
            icon: const Icon(
              Icons.shopping_cart,
              size: 36,
              color: ThemeColors.primaryColor,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: CheckProductInCartService()
            .checkProductInCart(productId: productModel.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool inCart = snapshot.data!;
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
                          Visibility(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
          } else if (snapshot.hasError) {
            return Container(
              color: Colors.red,
              height: 400,
            );
          } else {
            return Container(
              color: Colors.amber,
              height: 400,
            );
          }
        },
      ),
    );
  }
}
