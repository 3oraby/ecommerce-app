import 'package:e_commerce_app/features/favorites/data/models/get_favorites_response_model.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/custom_main_product_card.dart';
import 'package:e_commerce_app/features/products/data/models/show_product_details_arguments_model.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_product_details_page.dart';
import 'package:flutter/material.dart';

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
                Navigator.pushNamed(
                  context,
                  ShowProductDetailsPage.id,
                  arguments: ShowProductDetailsArgumentsModel(
                    lastPageId: HomePage.id,
                    productModel: product,
                  ),
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
