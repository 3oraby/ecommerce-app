
import 'package:e_commerce_app/features/home/presentation/widgets/home_page_shimmer_loading.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/taps/home/home_tap_loaded_body.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTapBody extends StatefulWidget {
  const HomeTapBody({super.key});

  @override
  State<HomeTapBody> createState() => _HomeTapBodyState();
}

class _HomeTapBodyState extends State<HomeTapBody> {
  final PageController pageController = PageController();
  late ProductCatalogCubit productCatalogCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize the cubit after dependencies are ready
    productCatalogCubit = BlocProvider.of<ProductCatalogCubit>(context);
    productCatalogCubit.getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCatalogCubit, ProductCatalogState>(
      builder: (context, state) {
        if (state is GetHomeDataLoadingState) {
          return const Scaffold(
            body: HomePageShimmerLoading(),
          );
        } else if (state is GetHomeDataErrorState) {
          return Scaffold(
            body: Center(
              child: Text(state.message),
            ),
          );
        } else if (state is GetHomeDataLoadedState) {
          return HomeTapLoadedBody(
            pageController: pageController,
            homeDetailsResponseModel: state.getHomeDetailsResponseModel,
            onShowAllTap: (categoryId) async {
              productCatalogCubit =
                  BlocProvider.of<ProductCatalogCubit>(context);
          
              productCatalogCubit.setSelectedCategoryId(categoryId);
              productCatalogCubit.getProductsByCategory(
                  categoryId: categoryId);
              productCatalogCubit.resetFilterArgumentsAppliedModel();
              final isRefresh = await Navigator.pushNamed(
                context,
                ShowProductsPage.id,
              );
              if (isRefresh is bool && isRefresh) {
                productCatalogCubit.getHomeData();
              }
            },
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
