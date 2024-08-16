import 'package:e_commerce_app/features/home/constants/home_page_constants.dart';
import 'package:e_commerce_app/features/home/data/data_sources/get_categories_service.dart';
import 'package:e_commerce_app/features/home/data/models/get_categories_response_model.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/custom_main_product_card.dart';
import 'package:e_commerce_app/features/products/data/data_sources/get_product_by_category_service.dart';
import 'package:e_commerce_app/features/products/data/models/get_products_response_model.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_product_details_page.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_products_page.dart';
import 'package:e_commerce_app/widgets/custom_rounded_image_container.dart';
import 'package:e_commerce_app/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/widgets/vertical_gap.dart';
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
              future: GetCategoriesService().getCategories(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  GetCategoriesResponseModel categoriesResponseModel =
                      snapshot.data!;
                  return ListView.separated(
                    itemCount: categoriesResponseModel.categories!.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.white,
                      thickness: 2,
                      indent: 20,
                      endIndent: 20,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => SizedBox(
                      height: 500,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                categoriesResponseModel.categories![index].name,
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
                                    arguments: categoriesResponseModel
                                        .categories![index].id,
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
                          FutureBuilder(
                            future: GetProductByCategoryService()
                                .getProductsByCategory(
                              categoryId:
                                  categoriesResponseModel.categories![index].id,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                GetProductsCategoryResponseModel
                                    getProductsCategoryResponseModel =
                                    snapshot.data!;
                                return SizedBox(
                                  height: 400,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: 5,
                                    separatorBuilder: (context, index) =>
                                        const HorizontalGap(16),
                                    itemBuilder: (context, productIndex) =>
                                        SizedBox(
                                      width: 250,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            ShowProductDetailsPage.id,
                                            arguments:
                                                getProductsCategoryResponseModel
                                                    .products![productIndex],
                                          );
                                        },
                                        child: CustomMainProductCard(
                                          productModel:
                                              getProductsCategoryResponseModel
                                                  .products![productIndex],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Container(
                                  height: 400,
                                  color: Colors.red,
                                );
                              } else {
                                return Container(
                                  height: 400,
                                  color: Colors.black,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Container(
                    height: 400,
                    color: Colors.orange,
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
