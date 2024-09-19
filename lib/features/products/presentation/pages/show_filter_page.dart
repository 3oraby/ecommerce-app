import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_option_list_tile.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/products/data/models/filter_arguments_model.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/pages/apply_price_filter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowFilterPage extends StatelessWidget {
  const ShowFilterPage({super.key});

  static const String id = "kShowFilterPage";

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width -
        (2 * LocalConstants.kHorizontalPadding);

    final ProductCatalogCubit productCatalogCubit =
        BlocProvider.of<ProductCatalogCubit>(context);
    List<ProductModel> products = [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Filters",
          style: TextStyles.aDLaMDisplayBlackBold26,
        ),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProductCatalogCubit, ProductCatalogState>(
        builder: (context, state) {
          // Display products based on the loaded state
          if (state is GetProductsByCategoryLoadedState) {
            products = state.products;
          }
          FilterArgumentsModel? filterArgumentsModel =
              productCatalogCubit.getFilterArgumentsAppliedModel;

          return Padding(
            padding: LocalConstants.internalPadding,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      CustomOptionListTile(
                        showLeadingWidget: false,
                        title: "Price",
                        subTitle: filterArgumentsModel?.minPrice == null
                            ? null
                            : "EGP ${filterArgumentsModel!.minPrice} - EGP ${filterArgumentsModel.maxPrice}",
                        internalPadding: const EdgeInsets.all(0),
                        onTap: () {
                          Navigator.pushNamed(context, ApplyPriceFilterPage.id);
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTriggerButton(
                      buttonWidth: screenWidth * 0.25,
                      buttonHeight: 55,
                      backgroundColor: Colors.white,
                      borderColor: ThemeColors.primaryColor,
                      borderWidth: 2,
                      description: "RESET",
                      descriptionColor: ThemeColors.primaryColor,
                      descriptionSize: 18,
                      onPressed: () {
                        productCatalogCubit.getProductsByCategory(
                          categoryId:
                              productCatalogCubit.getSelectedCategoryId!,
                        );
                        productCatalogCubit.resetFilterArgumentsAppliedModel();
                        Navigator.pop(context);
                      },
                    ),
                    CustomTriggerButton(
                      buttonWidth: screenWidth * 0.65,
                      buttonHeight: 55,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${products.length} Items",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const Text(
                              "APPLY",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const VerticalGap(16),
              ],
            ),
          );
        },
      ),
    );
  }
}
