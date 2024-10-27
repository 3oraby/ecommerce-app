import 'package:e_commerce_app/core/services/setup_get_it_service.dart';
import 'package:e_commerce_app/core/widgets/custom_no_internet_connection_body.dart';
import 'package:e_commerce_app/features/home/data/repositories/category_repository.dart';
import 'package:e_commerce_app/features/home/presentation/cubits/category_cubit.dart';
import 'package:e_commerce_app/features/home/presentation/cubits/category_state.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/taps/category/category_tap_loaded_body.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/taps/category/category_tap_loading_body.dart';
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
    final ProductCatalogCubit productCatalogCubit =
        BlocProvider.of<ProductCatalogCubit>(context);

    return BlocProvider(
      create: (context) => CategoryCubit(
        categoryRepository: getIt<CategoryRepository>(),
      )..getCategories(),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is GetCategoriesLoadingState) {
            return const CategoryTapLoadingBody();
          } else if (state is GetCategoriesErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is GetCategoriesLoadedState) {
            return CategoryTapLoadedBody(
              categories: state.categories,
              onCategoryTap: (index) {
                int categoryId = state.categories[index].id;
                productCatalogCubit.setSelectedCategoryId(categoryId);
                productCatalogCubit.getProductsByCategory(
                    categoryId: categoryId);
                Navigator.pushNamed(
                  context,
                  ShowProductsPage.id,
                );
              },
            );
          } else if (state is CategoryNoInternetConnectionState) {
            return CustomNoInternetConnectionBody(
              onTryAgainPressed: () {
                final CategoryCubit categoryCubit =
                    BlocProvider.of<CategoryCubit>(context);

                categoryCubit.getCategories();
              },
            );
          } else {
            return const Center(
              child: Text("There is no categories now"),
            );
          }
        },
      ),
    );
  }
}
