import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/navigation/home_page_navigation_service.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_rounded_image_container.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/home/constants/home_page_constants.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/custom_main_product_card.dart';
import 'package:e_commerce_app/features/products/data/models/get_home_details_model.dart';

import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeTapLoadedBody extends StatefulWidget {
  const HomeTapLoadedBody({
    super.key,
    required this.pageController,
    required this.homeDetailsResponseModel,
    required this.onShowAllTap,
  });

  final PageController pageController;
  final GetHomeDetailsResponseModel homeDetailsResponseModel;
  final void Function(int categoryId) onShowAllTap;

  @override
  State<HomeTapLoadedBody> createState() => _HomeTapLoadedBodyState();
}

class _HomeTapLoadedBodyState extends State<HomeTapLoadedBody> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          PromoImagesSection(pageController: widget.pageController),
          Center(
            child: SmoothPageIndicator(
              controller: widget.pageController,
              count: HomePageConstants.homeTapBodySalePhotos.length,
              effect: const WormEffect(
                activeDotColor: ThemeColors.primaryColor,
              ),
            ),
          ),
          const VerticalGap(24),
          ListView.separated(
            itemCount: widget.homeDetailsResponseModel.data!.length,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              int categoryId =
                  widget.homeDetailsResponseModel.data![index].categoryId;
              String categoryName =
                  widget.homeDetailsResponseModel.data![index].categoryName;
              List<ProductModel> products =
                  widget.homeDetailsResponseModel.data![index].products;
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
                          onPressed: () => widget.onShowAllTap(categoryId),
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
                        itemBuilder: (context, productIndex) => SizedBox(
                          width: 220,
                          child: GestureDetector(
                            onTap: () {
                              final ProductCatalogCubit productCatalogCubit =
                                  BlocProvider.of<ProductCatalogCubit>(
                                      context);
                              productCatalogCubit
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
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class PromoImagesSection extends StatelessWidget {
  const PromoImagesSection({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
