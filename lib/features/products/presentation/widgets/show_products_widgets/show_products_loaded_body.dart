import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_main_product_card.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/products/data/models/filter_arguments_model.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_filter_page.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_product_details_page.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_products_widgets/custom_pagination_widget.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_products_widgets/price_input_widget.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_products_widgets/show_available_filter_section.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_products_widgets/sort_and_filter_button_widget.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_products_widgets/sort_way_choose_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowProductsLoadedBody extends StatefulWidget {
  const ShowProductsLoadedBody({
    super.key,
    required this.products,
    required this.categoryId,
    this.isSearchingForProduct = false,
  });

  final List<ProductModel> products;
  final int categoryId;
  final bool isSearchingForProduct;

  @override
  State<ShowProductsLoadedBody> createState() => _ShowProductsLoadedBodyState();
}

class _ShowProductsLoadedBodyState extends State<ShowProductsLoadedBody> {
  late bool priceFilterApplied;
  String? minPrice;
  String? maxPrice;
  double? minPriceValue;
  double? maxPriceValue;

  late ProductCatalogCubit productCatalogCubit;
  FilterArgumentsModel? filterArgumentsModel;
  late String selectedSortOption;

  @override
  void initState() {
    super.initState();
    productCatalogCubit = BlocProvider.of<ProductCatalogCubit>(context);
    filterArgumentsModel = productCatalogCubit.getFilterArgumentsAppliedModel;
    priceFilterApplied = filterArgumentsModel?.minPrice != null &&
        filterArgumentsModel?.maxPrice != null;

    selectedSortOption = productCatalogCubit.getSelectedSortOption;

    if (filterArgumentsModel != null) {
      minPrice = filterArgumentsModel!.minPrice?.toString();
      maxPrice = filterArgumentsModel!.maxPrice?.toString();
    }
  }

  void onFilterTap() {
    Navigator.pushNamed(context, ShowFilterPage.id);
  }

  void applySort(String sortCriteria) {
    setState(() {
      productCatalogCubit.setSelectedSortOption(sortCriteria);

      if (sortCriteria == "Price: High to Low") {
        filterArgumentsModel?.sort = "price";
        filterArgumentsModel?.sortOrder = "DESC";
      } else if (sortCriteria == "Price: Low to High") {
        filterArgumentsModel?.sort = "price";
        filterArgumentsModel?.sortOrder = "ASC";
      } else {
        filterArgumentsModel?.sort = null;
        filterArgumentsModel?.sortOrder = null;
      }

      productCatalogCubit.getProductsByCategory(
        categoryId: widget.categoryId,
        queryParams: filterArgumentsModel?.toJson(),
      );
    });
  }

  void onSortTap() {
    double screenHeight = MediaQuery.of(context).size.height;

    final List<String> sortLabels = [
      "Popularity",
      "Price: High to Low",
      "Price: Low to High",
    ];

    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, modalSetState) => Container(
          height: screenHeight * 0.3,
          color: Colors.white,
          padding: const EdgeInsets.only(
            top: 32,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.cancel),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sortLabels.length,
                  itemBuilder: (context, index) => SortWayChooseWidget(
                    description: sortLabels[index],
                    isSelected: selectedSortOption == sortLabels[index],
                    onTap: () {
                      modalSetState(() {
                        selectedSortOption = sortLabels[index];
                      });
                      applySort(selectedSortOption);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onProductTap(context, productIndex) {
    productCatalogCubit.setSelectedProduct(widget.products[productIndex]);
    Navigator.pushNamed(
      context,
      ShowProductDetailsPage.id,
    );
  }

  bool _isApplyPriceFilterButtonEnabled() {
    minPriceValue = double.tryParse(minPrice ?? '');
    maxPriceValue = double.tryParse(maxPrice ?? '');

    return minPriceValue != null &&
        maxPriceValue != null &&
        minPriceValue! <= maxPriceValue!;
  }

  void onApplyPriceRangePressed(context) {
    filterArgumentsModel?.minPrice = minPriceValue;
    filterArgumentsModel?.maxPrice = maxPriceValue;
    filterArgumentsModel?.page = 1;
    productCatalogCubit.getProductsByCategory(
      categoryId: widget.categoryId,
      queryParams: filterArgumentsModel?.toJson(),
    );
    Navigator.pop(context, true);
  }

  void onPriceChanged(String value, bool isMinPrice) {
    if (isMinPrice) {
      minPrice = value;
    } else {
      maxPrice = value;
    }
  }

  void onPriceFilterPressed(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, modalSetState) => Container(
          height: screenHeight * 0.3,
          color: Colors.white,
          padding: LocalConstants.internalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalGap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Price", style: TextStyles.aDLaMDisplayBlackBold24),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    icon: const Icon(
                      Icons.cancel,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const VerticalGap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PriceInputWidget(
                      label: "Min",
                      initialValue: minPrice,
                      onChanged: (value) {
                        modalSetState(() {
                          onPriceChanged(value, true);
                        });
                      }),
                  const HorizontalGap(16),
                  PriceInputWidget(
                      label: "Max",
                      initialValue: maxPrice,
                      onChanged: (value) {
                        modalSetState(() {
                          onPriceChanged(value, false);
                        });
                      }),
                ],
              ),
              const VerticalGap(24),
              CustomTriggerButton(
                buttonHeight: 50,
                isEnabled: _isApplyPriceFilterButtonEnabled(),
                onPressed: () {
                  onApplyPriceRangePressed(context);
                },
                description: "APPLY",
                backgroundColor: _isApplyPriceFilterButtonEnabled()
                    ? ThemeColors.primaryColor
                    : ThemeColors.unEnabledButtonsColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShowAvailableFilterSection(
          priceFilterApplied: priceFilterApplied,
          onPriceFilterPressed: onPriceFilterPressed,
        ),
        Expanded(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: LocalConstants.kHorizontalPadding,
                  right: LocalConstants.kHorizontalPadding,
                  top: 40,
                  bottom: 80,
                ),
                child: ListView(
                  children: [
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.only(
                        bottom: widget.products.length % 2 == 0 ? 72 : 36,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 48,
                        childAspectRatio: 0.5,
                      ),
                      itemCount: widget.products.length,
                      itemBuilder: (context, index) => Transform.translate(
                        offset: Offset(0, index.isOdd ? 36 : 0),
                        child: GestureDetector(
                          onTap: () {
                            onProductTap(context, index);
                          },
                          child: CustomMainProductCard(
                            productModel: widget.products[index],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !widget.isSearchingForProduct,
                      child: CustomPaginationWidget(
                        filterArgumentsModel: filterArgumentsModel,
                      ),
                    ),
                  ],
                ),
              ),
              SortAndFilterButtonWidget(
                onFilterTap: onFilterTap,
                onSortTap: onSortTap,
                filterIsSelected: priceFilterApplied,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
