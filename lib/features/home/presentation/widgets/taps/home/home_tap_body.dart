import 'package:e_commerce_app/core/widgets/custom_no_internet_connection_body.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/home_page_shimmer_loading.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/taps/home/home_tap_loaded_body.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTapBody extends StatefulWidget {
  const HomeTapBody({super.key});
  static const String id = "kHomeTapBody";

  @override
  State<HomeTapBody> createState() => _HomeTapBodyState();
}

class _HomeTapBodyState extends State<HomeTapBody> {
  final PageController pageController = PageController();
  late ProductCatalogCubit productCatalogCubit;

  @override
  void initState() {
    super.initState();
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
          return const Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "There is a problem in the server now , please try again later"),
              ),
            ),
          );
        } else if (state is GetHomeDataLoadedState) {
          return HomeTapLoadedBody(
            pageController: pageController,
            homeDetailsResponseModel: state.getHomeDetailsResponseModel,
            onShowAllTap: (categoryId) {
              productCatalogCubit.setSelectedCategoryId(categoryId);
              productCatalogCubit.getProductsByCategory(categoryId: categoryId);
              productCatalogCubit.resetFilterArgumentsAppliedModel();
              Navigator.pushNamed(
                context,
                ShowProductsPage.id,
                arguments: HomeTapBody.id,
              );
            },
          );
        } else if (state is ProductNoInternetConnectionState) {
          return CustomNoInternetConnectionBody(
            onTryAgainPressed: () {
              productCatalogCubit.getHomeData();
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
