import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_rounded_image_container.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/home/constants/home_page_constants.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/taps/home/horizontal_list_view_home_tap_section.dart';
import 'package:e_commerce_app/features/products/data/models/get_home_details_model.dart';

import 'package:flutter/material.dart';
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
          const VerticalGap(8),
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
              return Column(
                children: [
                  ShowCategoryNameAndShowAllButtonSection(
                    categoryName: categoryName,
                    categoryId: categoryId,
                    onShowAllTap: widget.onShowAllTap,
                  ),
                  const VerticalGap(16),
                  HorizontalListViewHomeTapSection(products: products),
                  const VerticalGap(16),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class ShowCategoryNameAndShowAllButtonSection extends StatelessWidget {
  const ShowCategoryNameAndShowAllButtonSection({
    super.key,
    required this.categoryName,
    required this.categoryId,
    required this.onShowAllTap,
  });

  final String categoryName;
  final int categoryId;
  final void Function(int categoryId) onShowAllTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          categoryName,
          style: TextStyles.aDLaMDisplayBlackBold28,
        ),
        TextButton(
          onPressed: () => onShowAllTap(categoryId),
          child: const Text(
            "show all",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
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
      height: MediaQuery.of(context).size.height * 0.2,
      child: PageView.builder(
        controller: pageController,
        allowImplicitScrolling: true,
        itemCount: HomePageConstants.homeTapBodySalePhotos.length,
        itemBuilder: (context, index) => Center(
          child: CustomRoundedImageContainer(
            imagePath: HomePageConstants.homeTapBodySalePhotos[index],
            inAsset: true,
            borderRadius: LocalConstants.kBorderRadius,
          ),
        ),
      ),
    );
  }
}
