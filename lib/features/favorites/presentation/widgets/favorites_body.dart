
import 'package:e_commerce_app/core/utils/navigation/home_page_navigation_service.dart';
import 'package:e_commerce_app/features/favorites/data/data_sources/get_favorites_service.dart';
import 'package:e_commerce_app/features/favorites/data/models/get_favorites_response_model.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/custom_main_product_card.dart';
import 'package:e_commerce_app/features/products/data/models/show_product_details_arguments_model.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_product_details_page.dart';
import 'package:flutter/material.dart';

class FavoritesBody extends StatefulWidget {
  const FavoritesBody({super.key});

  @override
  State<FavoritesBody> createState() => _FavoritesBodyState();
}

class _FavoritesBodyState extends State<FavoritesBody> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 48,
      ),
      child: FutureBuilder(
        future: GetFavoritesService().getFavorites(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            GetFavoritesResponseModel data = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 48,
                childAspectRatio: 0.5,
              ),
              itemCount: data.favoriteProducts!.length,
              itemBuilder: (context, index) => Transform.translate(
                offset: Offset(0,
                    index.isOdd ? 36 : 0), // shift the right products to bottom
                child: GestureDetector(
                  onTap: () {
                    HomePageNavigationService.navigateToFavorites();
                    Navigator.pushNamed(
                      context,
                      ShowProductDetailsPage.id,
                      arguments: ShowProductDetailsArgumentsModel(
                        lastPageId: HomePage.id,
                        productModel: data.favoriteProducts![index],
                      ),
                    );
                  },
                  child: CustomMainProductCard(
                    productModel: data.favoriteProducts![index],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Container(
              height: 400,
              color: Colors.red,
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
            );
          } else {
            return Container(
              height: 400,
              color: Colors.amber,
            );
          }
        },
      ),
    );
  }
}
