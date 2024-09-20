
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/products/data/models/filter_arguments_model.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomPaginationWidget extends StatefulWidget {
  const CustomPaginationWidget({super.key, required this.filterArgumentsModel});
  final FilterArgumentsModel? filterArgumentsModel;
  @override
  State<CustomPaginationWidget> createState() => _CustomPaginationWidgetState();
}

class _CustomPaginationWidgetState extends State<CustomPaginationWidget> {
  late int totalPages;
  late int currentPage;
  late ProductCatalogCubit productCatalogCubit;
  @override
  void initState() {
    super.initState();
    productCatalogCubit = BlocProvider.of<ProductCatalogCubit>(context);
    totalPages = productCatalogCubit.getTotalPages!;
    currentPage = productCatalogCubit.getCurrentPage!;
  }

  void onPageSelected(int page) {
    setState(() {
      currentPage = page;
      widget.filterArgumentsModel!.page = page;
    });
    productCatalogCubit.getProductsByCategory(
      categoryId: productCatalogCubit.getSelectedCategoryId!,
      queryParams: widget.filterArgumentsModel!.toJson(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (currentPage > 1)
          IconButton(
            onPressed: () {
              if (currentPage > 1) {
                onPageSelected(currentPage - 1);
              }
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        if (currentPage > 1)
          TextButton(
            onPressed: () {
              onPageSelected(currentPage - 1);
            },
            child: pageButton(context, currentPage - 1),
          ),
        TextButton(
          onPressed: () {},
          child: pageButton(context, currentPage, isSelected: true),
        ),
        if (currentPage < totalPages)
          TextButton(
            onPressed: () {
              onPageSelected(currentPage + 1);
            },
            child: pageButton(context, currentPage + 1),
          ),
        if (currentPage < totalPages)
          IconButton(
            onPressed: () {
              if (currentPage < totalPages) {
                onPageSelected(currentPage + 1);
              }
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
      ],
    );
  }

  Widget pageButton(BuildContext context, int page, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? ThemeColors.primaryColor
            : Colors.transparent, 
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "$page",
        style: TextStyle(
          fontSize: 18,
          color: isSelected
              ? Colors.white 
              : Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.color, 
        ),
      ),
    );
  }
}
