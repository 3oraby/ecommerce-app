import 'dart:developer';

import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_empty_body_widget.dart';
import 'package:e_commerce_app/core/widgets/custom_no_internet_connection_body.dart';
import 'package:e_commerce_app/core/widgets/grid_view_items_loading.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/taps/category/category_tap_body.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/taps/home/home_tap_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/widgets/custom_text_form_field.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_products_widgets/show_products_loaded_body.dart';

class ShowProductsPage extends StatefulWidget {
  const ShowProductsPage({super.key});
  static const String id = "showProductsPage";

  @override
  State<ShowProductsPage> createState() => _ShowProductsPageState();
}

class _ShowProductsPageState extends State<ShowProductsPage> {
  late int categoryId;
  late ProductCatalogCubit productCatalogCubit;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    productCatalogCubit = BlocProvider.of<ProductCatalogCubit>(context);
    categoryId = productCatalogCubit.getSelectedCategoryId!;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String lastPage = ModalRoute.of(context)!.settings.arguments as String;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          if (lastPage == HomeTapBody.id) {
            log("pop to home tap body");
            productCatalogCubit.getHomeData();
          } else if (lastPage == CategoryTapBody.id) {
            log("pop to category tap body");
          }
        }
      },
      child: Scaffold(
        backgroundColor: ThemeColors.backgroundBodiesColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          title: CustomTextFormFieldWidget(
            controller: _searchController,
            hintText: "Search for a product",
            borderWidth: 0,
            enabledBorderWidth: 0,
            borderColor: Colors.white,
            enabledBorderColor: Colors.white,
            suffixIcon: const Icon(
              Icons.search,
              color: Colors.black,
              size: 35,
            ),
            fillColor: ThemeColors.backgroundBodiesColor,
            hintStyle: const TextStyle(
              color: Colors.black,
            ),
            borderRadius: LocalConstants.kBorderRadius,
            focusedBorderColor: Colors.transparent,
            onChanged: (value) {
              productCatalogCubit.searchInProducts(
                categoryId: categoryId,
                productName: value,
              );
            },
          ),
        ),
        body: BlocListener<ProductCatalogCubit, ProductCatalogState>(
          listener: (context, state) {
            if (state is GetProductsByCategoryLoadedState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _searchController.clear();
              });
            }
          },
          child: BlocBuilder<ProductCatalogCubit, ProductCatalogState>(
            builder: (context, state) {
              if (state is GetProductsByCategoryLoadingState ||
                  state is SearchInProductsLoadingState) {
                return const GridViewItemsLoading();
              } else if (state is GetProductsByCategoryErrorState ||
                  state is SearchInProductsErrorState) {
                return Center(
                  child: Text((state as dynamic).message),
                );
              } else if (state is SearchInProductsLoadedState) {
                return ShowProductsLoadedBody(
                  products: state.products,
                  categoryId: categoryId,
                  isSearchingForProduct: true,
                );
              } else if (state is GetProductsByCategoryLoadedState) {
                productCatalogCubit
                    .setFilterArgumentsAppliedModel(state.filterArgumentsModel);
                return ShowProductsLoadedBody(
                  products: state.products,
                  categoryId: categoryId,
                );
              } else if (state is ProductNoInternetConnectionState) {
                return CustomNoInternetConnectionBody(
                  onTryAgainPressed: () {
                    productCatalogCubit.getProductsByCategory(
                      categoryId: categoryId,
                      queryParams: productCatalogCubit
                          .getFilterArgumentsAppliedModel
                          ?.toJson(),
                    );
                  },
                );
              } else if (state is GetProductsByCategoryEmptyState ||
                  state is SearchInProductsEmptyState) {
                return const CustomEmptyBodyWidget(
                  mainLabel: 'No products found!',
                  subLabel: 'Try searching for something else.',
                );
              } else if (state is SearchInProductsEmptyState) {
                return const CustomEmptyBodyWidget(
                  mainLabel: 'No products match your filter!',
                  subLabel: 'Try adjusting your filter criteria.',
                );
              } else {
                return const Center(
                  child: Text("Cannot get products"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
