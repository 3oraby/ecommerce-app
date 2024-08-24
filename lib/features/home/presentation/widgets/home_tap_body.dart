import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/navigation/home_page_navigation_service.dart';
import 'package:e_commerce_app/features/home/constants/home_page_constants.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/custom_main_product_card.dart';
import 'package:e_commerce_app/features/products/data/data_sources/get_home_details_service.dart';
import 'package:e_commerce_app/features/products/data/models/get_home_details_model.dart';
import 'package:e_commerce_app/features/products/data/models/show_product_details_arguments_model.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_product_details_page.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_products_page.dart';
import 'package:e_commerce_app/core/widgets/custom_rounded_image_container.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeTapBody extends StatefulWidget {
  const HomeTapBody({super.key});

  @override
  State<HomeTapBody> createState() => _HomeTapBodyState();
}

class _HomeTapBodyState extends State<HomeTapBody> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.backgroundBodiesColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: pageController,
                allowImplicitScrolling: true,
                itemCount: HomePageConstants.homeTapBodySalePhotos.length,
                itemBuilder: (context, index) => Center(
                  child: CustomRoundedImageContainer(
                    imagePath: HomePageConstants.homeTapBodySalePhotos[index],
                    inAsset: true,
                  ),
                ),
              ),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: HomePageConstants.homeTapBodySalePhotos.length,
                effect: const WormEffect(
                  activeDotColor: ThemeColors.primaryColor,
                ),
              ),
            ),
            const VerticalGap(24),
            FutureBuilder(
              future: GetHomeDetailsService().getHomeData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  GetHomeDetailsResponseModel homeDetailsResponseModel =
                      snapshot.data!;
                  return ListView.separated(
                    itemCount: homeDetailsResponseModel.data!.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.white,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      int categoryId =
                          homeDetailsResponseModel.data![index].categoryId;
                      String categoryName =
                          homeDetailsResponseModel.data![index].categoryName;
                      List<ProductModel> products =
                          homeDetailsResponseModel.data![index].products;
                      return SizedBox(
                        height: 500,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  categoryName,
                                  style: GoogleFonts.aDLaMDisplay(
                                    color: Colors.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      ShowProductsPage.id,
                                      arguments: categoryId,
                                    );
                                  },
                                  child: const Text(
                                    "show all",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const VerticalGap(16),
                            SizedBox(
                              height: 400,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: products.length,
                                separatorBuilder: (context, index) =>
                                    const HorizontalGap(16),
                                itemBuilder: (context, productIndex) =>
                                    SizedBox(
                                  width: 220,
                                  child: GestureDetector(
                                    onTap: () {
                                      HomePageNavigationService
                                          .navigateToHome();
                                      Navigator.pushNamed(
                                        context,
                                        ShowProductDetailsPage.id,
                                        arguments:
                                            ShowProductDetailsArgumentsModel(
                                          lastPageId: HomePage.id,
                                          productModel: products[productIndex],
                                        ),
                                      );
                                    },
                                    child: CustomMainProductCard(
                                      productModel: products[productIndex],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Container(
                    height: 400,
                    color: Colors.red,
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return Container(
                    height: 400,
                    color: Colors.amber,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
