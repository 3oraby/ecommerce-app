import 'package:e_commerce_app/core/utils/navigation/home_page_navigation_service.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_state.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:e_commerce_app/features/reviews/presentation/cubit/review_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_product_details_widgets/show_products_details_loaded_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowProductDetailsPage extends StatelessWidget {
  const ShowProductDetailsPage({super.key});
  static const id = "showProductDetailsPage";

  @override
  Widget build(BuildContext context) {
    final ProductCatalogCubit productCatalogCubit =
        BlocProvider.of<ProductCatalogCubit>(context);
    final CartCubit cartCubit = BlocProvider.of<CartCubit>(context);
    final ReviewCubit reviewCubit = BlocProvider.of<ReviewCubit>(context);

    final ProductModel productModel = productCatalogCubit.getSelectedProduct!;
    cartCubit.checkProductInCart(productModel.id);
    reviewCubit.getProductReviews(productId: productModel.id);

    return Scaffold(
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
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
          if (cartState is CartRefreshPageState) {
            cartCubit.checkProductInCart(productModel.id);
          }
        },
        builder: (context, cartState) {
          return BlocBuilder<ReviewCubit, ReviewState>(
            builder: (context, reviewState) {
              if (cartState is CartLoadingState ||
                  reviewState is GetReviewsLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (cartState is CartErrorState) {
                return Center(child: Text(cartState.message));
              } else if (reviewState is GetReviewsErrorState) {
                return Center(child: Text(reviewState.message));
              } else if (cartState is CheckProductInCartLoadedState &&
                  reviewState is GetReviewsLoadedState) {
                return ShowProductsDetailsLoadedBody(
                  productModel: productModel,
                  inCart: cartState.inCart,
                  productQuantityInCart: cartState.productQuantityInCart,
                  productReviews: reviewState.productReviews,
                  averageRating: reviewState.averageRating,
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }
}
