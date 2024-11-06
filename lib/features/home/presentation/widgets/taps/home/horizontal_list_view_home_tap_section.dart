import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/navigation/home_page_navigation_service.dart';
import 'package:e_commerce_app/core/widgets/custom_main_product_card.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HorizontalListViewHomeTapSection extends StatelessWidget {
  const HorizontalListViewHomeTapSection({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: products.length,
        separatorBuilder: (context, index) => const HorizontalGap(16),
        itemBuilder: (context, productIndex) => SizedBox(
          width: 220,
          child: GestureDetector(
            onTap: () {
              BlocProvider.of<ProductCatalogCubit>(context)
                  .setSelectedProduct(products[productIndex]);
              HomePageNavigationService.navigateToHome();
              Navigator.pushNamed(
                context,
                ShowProductDetailsPage.id,
              );
            },
            child: CustomMainProductCard(
              productModel: products[productIndex],
            ),
          ),
        ),
      ),
    );
  }
}