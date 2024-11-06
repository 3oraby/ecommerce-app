import 'package:e_commerce_app/core/widgets/custom_main_product_card.dart';
import 'package:e_commerce_app/features/favorites/data/models/get_favorites_response_model.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesLoadedBody extends StatelessWidget {
  const FavoritesLoadedBody({
    super.key,
    required this.getFavoritesResponseModel,
  });
  final GetFavoritesResponseModel getFavoritesResponseModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 48,
      ),
      child: GridView.builder(
        padding: const EdgeInsets.only(
          bottom: 48,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 48,
          childAspectRatio: 0.5,
        ),
        itemCount: getFavoritesResponseModel.favoriteProducts?.length ?? 0,
        itemBuilder: (context, index) {
          final product = getFavoritesResponseModel.favoriteProducts![index];
          return Transform.translate(
            offset: Offset(0, index.isOdd ? 36 : 0),
            child: GestureDetector(
              onTap: () {
                final ProductCatalogCubit productCatalogCubit =
                    BlocProvider.of<ProductCatalogCubit>(context);
                productCatalogCubit.setSelectedProduct(product);
                Navigator.pushNamed(
                  context,
                  ShowProductDetailsPage.id,
                );
              },
              child: CustomMainProductCard(
                productModel: product,
                isFavoritePage: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
