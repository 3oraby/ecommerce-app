
import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/custom_main_product_card.dart';
import 'package:e_commerce_app/features/products/data/models/show_product_details_arguments_model.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_product_details_page.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_products_page.dart';
import 'package:flutter/material.dart';

class ShowProductsLoadedBody extends StatelessWidget {
  const ShowProductsLoadedBody({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: LocalConstants.kHorizontalPadding,
        vertical: 48,
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 48,
          childAspectRatio: 0.5,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) => Transform.translate(
          offset: Offset(
              0, index.isOdd ? 36 : 0), // shift the right products to bottom
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                ShowProductDetailsPage.id,
                arguments: ShowProductDetailsArgumentsModel(
                  lastPageId: ShowProductsPage.id,
                  productModel: products[index],
                ),
              );
            },
            child: CustomMainProductCard(
              productModel: products[index],
            ),
          ),
        ),
      ),
    );
  }
}
