import 'package:e_commerce_app/core/helpers/functions/is_user_signed_in.dart';
import 'package:e_commerce_app/core/utils/navigation/home_page_navigation_service.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/widgets/custom_no_internet_connection_body.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_state.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/cart_body.dart';
import 'package:e_commerce_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:e_commerce_app/features/favorites/presentation/widgets/favorites_body.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_product_details_widgets/show_products_details_loading_body.dart';
import 'package:e_commerce_app/features/reviews/presentation/cubit/review_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_product_details_widgets/show_products_details_loaded_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowProductDetailsPage extends StatefulWidget {
  const ShowProductDetailsPage({super.key});
  static const id = "showProductDetailsPage";

  @override
  State<ShowProductDetailsPage> createState() => _ShowProductDetailsPageState();
}

class _ShowProductDetailsPageState extends State<ShowProductDetailsPage> {
  late ProductCatalogCubit productCatalogCubit;
  late CartCubit cartCubit;
  late ReviewCubit reviewCubit;
  late FavoritesCubit favoritesCubit;
  late ProductModel productModel;

  @override
  void initState() {
    super.initState();
    productCatalogCubit = BlocProvider.of<ProductCatalogCubit>(context);
    cartCubit = BlocProvider.of<CartCubit>(context);
    reviewCubit = BlocProvider.of<ReviewCubit>(context);
    favoritesCubit = BlocProvider.of<FavoritesCubit>(context);

    productModel = productCatalogCubit.getSelectedProduct!;
    if (isUserSignedIn()) {
      cartCubit.checkProductInCart(productModel.id);
    }
    reviewCubit.getProductReviews(productId: productModel.id);
  }

  @override
  Widget build(BuildContext context) {
    String? lastPage = ModalRoute.of(context)!.settings.arguments as String?;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          if (lastPage == FavoritesBody.id) {
            favoritesCubit.getFavorites();
          } else if (lastPage == CartBody.id) {
            cartCubit.showCartAndPrice();
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            "Product Details",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                HomePageNavigationService.navigateToCart();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  HomePage.id,
                  (Route<dynamic> route) => false,
                );
              },
              icon: const Icon(
                Icons.shopping_cart,
                size: 36,
                color: ThemeColors.primaryColor,
              ),
            ),
          ],
        ),
        body: BlocConsumer<CartCubit, CartState>(
          listener: (context, cartState) {
            if (cartState is CartRefreshPageState && isUserSignedIn()) {
              cartCubit.checkProductInCart(productModel.id);
            }
          },
          buildWhen: (previous, current) {
            return current is CartLoadingState ||
                current is CartErrorState ||
                current is CheckProductInCartLoadedState ||
                current is CartNoNetworkErrorState;
          },
          builder: (context, cartState) {
            return BlocBuilder<ReviewCubit, ReviewState>(
              builder: (context, reviewState) {
                if (cartState is CartLoadingState ||
                    reviewState is GetReviewsLoadingState) {
                  return const ShowProductsDetailsLoadingBody();
                } else if (cartState is CartErrorState) {
                  return Center(child: Text(cartState.message));
                } else if (reviewState is GetReviewsErrorState) {
                  return Center(child: Text(reviewState.message));
                } else if (cartState is CheckProductInCartLoadedState &&
                    reviewState is GetReviewsLoadedState &&
                    isUserSignedIn()) {
                  return ShowProductsDetailsLoadedBody(
                    productModel: productModel,
                    inCart: cartState.inCart,
                    productQuantityInCart: cartState.productQuantityInCart,
                    productReviews: reviewState.productReviews,
                    averageRating: reviewState.averageRating,
                  );
                } else if (cartState is CartNoNetworkErrorState) {
                  return CustomNoInternetConnectionBody(onTryAgainPressed: () {
                    if (isUserSignedIn()) {
                      cartCubit.checkProductInCart(productModel.id);
                    }
                    reviewCubit.getProductReviews(productId: productModel.id);
                  });
                } else if (reviewState is GetReviewsLoadedState) {
                  return ShowProductsDetailsLoadedBody(
                    productModel: productModel,
                    inCart: false,
                    productReviews: reviewState.productReviews,
                    averageRating: reviewState.averageRating,
                  );
                }
                return Container();
              },
            );
          },
        ),
      ),
    );
  }
}
