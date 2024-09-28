import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/show_error_with_internet_dialog.dart';
import 'package:e_commerce_app/core/helpers/functions/show_snack_bar.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/features/products/data/models/filter_arguments_model.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_products_widgets/price_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplyPriceFilterPage extends StatefulWidget {
  const ApplyPriceFilterPage({super.key});

  static const String id = "kApplyPriceFilterPage";
  @override
  State<ApplyPriceFilterPage> createState() => _ApplyPriceFilterPageState();
}

class _ApplyPriceFilterPageState extends State<ApplyPriceFilterPage> {
  bool isLoading = false;
  String? minPrice;
  String? maxPrice;
  bool internetConnection = true;

  double? minPriceValue;
  double? maxPriceValue;
  late ProductCatalogCubit productCatalogCubit;
  FilterArgumentsModel? filterArgumentsModel;
  @override
  void initState() {
    super.initState();
    productCatalogCubit = BlocProvider.of<ProductCatalogCubit>(context);
    filterArgumentsModel = productCatalogCubit.getFilterArgumentsAppliedModel;
    if (filterArgumentsModel != null) {
      minPrice = filterArgumentsModel!.minPrice?.toString();
      maxPrice = filterArgumentsModel!.maxPrice?.toString();
    }
  }

  bool _isApplyPriceFilterButtonEnabled() {
    minPriceValue = double.tryParse(minPrice ?? '');
    maxPriceValue = double.tryParse(maxPrice ?? '');

    return minPriceValue != null &&
        maxPriceValue != null &&
        minPriceValue! <= maxPriceValue!;
  }

  void onApplyPriceRangePressed(context) async {
    FilterArgumentsModel filterArgumentsModel = FilterArgumentsModel();
    filterArgumentsModel.minPrice = minPriceValue;
    filterArgumentsModel.maxPrice = maxPriceValue;
    int categoryId = productCatalogCubit.getSelectedCategoryId!;
    await productCatalogCubit.getProductsByCategory(
      categoryId: categoryId,
      queryParams: filterArgumentsModel.toJson(),
    );
    productCatalogCubit.setFilterArgumentsAppliedModel(filterArgumentsModel);
  }

  void onPriceChanged(String value, bool isMinPrice) {
    if (isMinPrice) {
      minPrice = value;
    } else {
      maxPrice = value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Choose Price range",
          style: TextStyles.aDLaMDisplayBlackBold26,
        ),
        centerTitle: true,
      ),
      body: BlocListener<ProductCatalogCubit, ProductCatalogState>(
        listener: (context, state) {
          if (state is GetProductsByCategoryLoadedState) {
            setState(() {
              isLoading = false;
            });
            if (state.products.isEmpty) {
              showEmptyProductsDialog(context);
            } else {
              Navigator.pop(context, true);
            }
          } else if (state is GetProductsByCategoryLoadingState) {
            setState(() {
              isLoading = true;
            });
          } else if (state is GetProductsByCategoryErrorState) {
            setState(() {
              isLoading = true;
            });
            showSnackBar(context, state.message);
          } else if (state is ProductNoInternetConnectionState) {
            Navigator.pop(context, true);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: LocalConstants.kHorizontalPadding,
            vertical: 24,
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PriceInputWidget(
                        label: "Min",
                        initialValue: minPrice,
                        onChanged: (value) {
                          setState(() {
                            onPriceChanged(value, true);
                          });
                        }),
                    const HorizontalGap(16),
                    PriceInputWidget(
                        label: "Max",
                        initialValue: maxPrice,
                        onChanged: (value) {
                          setState(() {
                            onPriceChanged(value, false);
                          });
                        }),
                  ],
                ),
              ),
              CustomTriggerButton(
                buttonHeight: 50,
                isEnabled: _isApplyPriceFilterButtonEnabled(),
                onPressed: () {
                  internetConnection
                      ? onApplyPriceRangePressed(context)
                      : showErrorWithInternetDialog(context);
                },
                description: "APPLY",
                backgroundColor: _isApplyPriceFilterButtonEnabled()
                    ? ThemeColors.primaryColor
                    : ThemeColors.unEnabledButtonsColor,
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showEmptyProductsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Sorry, we could not find any products'),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "OK",
                style: TextStyle(
                  color: ThemeColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
