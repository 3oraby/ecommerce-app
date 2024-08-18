import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_product_details_widgets/amount_selector_section.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_product_details_widgets/description_section.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_product_details_widgets/price_and_cart_button_section.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_product_details_widgets/product_title_section.dart';
import 'package:flutter/material.dart';

class ShowProductDetailsPage extends StatefulWidget {
  const ShowProductDetailsPage({super.key});
  static const id = "showProductDetailsPage";

  @override
  State<ShowProductDetailsPage> createState() => _ShowProductDetailsPageState();
}

class _ShowProductDetailsPageState extends State<ShowProductDetailsPage> {
  int productAmount = 0;

  void increaseAmount() {
    setState(() {
      if (productAmount < 20) {
        productAmount += 1;
      }
    });
  }

  void decreaseAmount() {
    setState(() {
      if (productAmount > 0) {
        productAmount -= 1;
      }
    });
  }

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
              //! go to cart body
            },
            icon: const Icon(
              Icons.shopping_cart,
              size: 36,
              color: ThemeColors.primaryColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                "${ApiConstants.baseUrl}${ApiConstants.getPhotoEndPoint}${productModel.photo}",
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: ThemeColors.backgroundBodiesColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Column(
                    children: [
                      const Spacer(),
                      ProductTitleSection(productModel: productModel),
                      const Divider(color: Colors.white, thickness: 1),
                      const Spacer(),
                      DescriptionSection(productModel: productModel),
                      const Spacer(),
                      const Divider(color: Colors.white, thickness: 1),
                      const Spacer(),
                      AmountSelectorSection(
                        productAmount: productAmount,
                        onAdd: increaseAmount,
                        onRemove: decreaseAmount,
                      ),
                      const Spacer(),
                      PriceAndCartButtonSection(
                        productModel: productModel,
                        productAmount: productAmount,
                      ),
                      const Spacer(flex: 6),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
