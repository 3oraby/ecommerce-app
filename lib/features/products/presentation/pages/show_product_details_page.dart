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

class ShowProductDetailsPage extends StatefulWidget {
  const ShowProductDetailsPage({super.key});
  static const id = "showProductDetailsPage";

  @override
  State<ShowProductDetailsPage> createState() => _ShowProductDetailsPageState();
}

class _ShowProductDetailsPageState extends State<ShowProductDetailsPage> {
  late ProductModel productModel;
  late CartCubit cartCubit;
  late ReviewCubit reviewCubit;
  bool cartLoaded = false;
  bool reviewsLoaded = false;

  @override
  void initState() {
    super.initState();
    final ProductCatalogCubit productCatalogCubit =
        BlocProvider.of<ProductCatalogCubit>(context);
    productModel = productCatalogCubit.getSelectedProduct!;

    // Trigger both requests at the same time
    cartCubit = BlocProvider.of<CartCubit>(context);
    reviewCubit = BlocProvider.of<ReviewCubit>(context);

    cartCubit.checkProductInCart(productModel.id);
    reviewCubit.getProductReviews(
        productId: productModel.id); // Trigger reviews request
  }

  @override
  Widget build(BuildContext context) {
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
      body: MultiBlocListener(
        listeners: [
          BlocListener<CartCubit, CartState>(
            listener: (context, state) {
              if (state is CheckProductInCartLoadedState ||
                  state is CartErrorState) {
                setState(() {
                  cartLoaded = true;
                });
              }
            },
          ),
          BlocListener<ReviewCubit, ReviewState>(
            listener: (context, state) {
              if (state is GetReviewsLoadedState ||
                  state is GetReviewsErrorState) {
                setState(() {
                  reviewsLoaded = true;
                });
              }
            },
          ),
        ],
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, cartState) {
            return BlocBuilder<ReviewCubit, ReviewState>(
              builder: (context, reviewState) {
                // Show loading if either cart or reviews data is still being fetched
                if (!cartLoaded || !reviewsLoaded) {
                  return const Center(child: CircularProgressIndicator());
                } else if (cartState is CartErrorState) {
                  return Center(child: Text(cartState.message));
                } else if (reviewState is GetReviewsErrorState) {
                  return Center(child: Text(reviewState.message));
                } else if (cartState is CartRefreshPageState) {
                  cartCubit.checkProductInCart(productModel.id);
                  cartLoaded = false;
                  return const Center(
                    child: Text("in refresh state"),
                  );
                } else if (cartState is CheckProductInCartLoadedState &&
                    reviewState is GetReviewsLoadedState) {
                  // Both data sets (cart and reviews) are loaded
                  return ShowProductsDetailsLoadedBody(
                    productModel: productModel,
                    inCart: cartState.inCart,
                    productQuantityInCart: cartState.productQuantityInCart,
                    productReviews:
                        reviewState.productReviews, // Pass the loaded reviews
                  );
                } else {
                  return Container(); // Fallback case
                }
              },
            );
          },
        ),
      ),
    );
  }
}
