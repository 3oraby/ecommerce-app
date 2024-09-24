import 'package:e_commerce_app/core/widgets/custom_no_internet_connection_body.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/taps/category/category_tap_loaded_body.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTapBody extends StatefulWidget {
  const CategoryTapBody({super.key});

  @override
  State<CategoryTapBody> createState() => _CategoryTapBodyState();
}

class _CategoryTapBodyState extends State<CategoryTapBody> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final productCatalogCubit = BlocProvider.of<ProductCatalogCubit>(context);
    productCatalogCubit.getCategories();

    return BlocBuilder<ProductCatalogCubit, ProductCatalogState>(
      builder: (context, state) {
        if (state is GetCategoriesLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetCategoriesErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is GetCategoriesLoadedState) {
          return CategoryTapLoadedBody(
            categories: state.categories,
            onCategoryTap: (index) async {
              int categoryId = state.categories[index].id;
              productCatalogCubit.setSelectedCategoryId(categoryId);
              productCatalogCubit.getProductsByCategory(categoryId: categoryId);
              final isRefresh = await Navigator.pushNamed(
                context,
                ShowProductsPage.id,
              );
              if (isRefresh is bool && isRefresh) {
                productCatalogCubit.getCategories();
              }
            },
          );
        }else if (state is ProductNoInternetConnectionState){
          return CustomNoInternetConnectionBody(
            onTryAgainPressed: () {
              productCatalogCubit.getCategories();
            },
          );
        }
         else {
          return const Center(
            child: Text("can not fetch categories"),
          );
        }
      },
    );
  }
}
