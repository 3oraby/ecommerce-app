import 'package:e_commerce_app/core/utils/app_assets/images/app_images.dart';
import 'package:e_commerce_app/core/widgets/custom_empty_body_widget.dart';
import 'package:e_commerce_app/core/widgets/custom_no_internet_connection_body.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_state.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/cart_body_shimmer_loading.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/cart_body_widgets/cart_body_loaded.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBody extends StatefulWidget {
  const CartBody({super.key});

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  bool isDeleteItemLoading = false;
  @override
  Widget build(BuildContext context) {
    final ProductCatalogCubit productCatalogCubit =
        BlocProvider.of<ProductCatalogCubit>(context);
    final CartCubit cartCubit = BlocProvider.of<CartCubit>(context);
    cartCubit.showCartAndPrice();

    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) {
        return current is ShowCartLoadingState ||
            current is ShowCartErrorState ||
            current is CartAndPriceLoadedState ||
            current is EmptyCartState ||
            current is CartNoNetworkErrorState;
      },
      builder: (context, state) {
        if (state is ShowCartLoadingState) {
          return const CartBodyShimmerLoading();
        } else if (state is ShowCartErrorState) {
          return SizedBox(
            child: Text(state.message),
          );
        } else if (state is CartAndPriceLoadedState) {
          return CartBodyLoaded(
            showCartResponseModel: state.cart,
            cartPrice: state.price,
            totalQuantity: state.totalQuantity,
            onProductTap: (selectedProductIndex) {
              productCatalogCubit.setSelectedProduct(
                  state.cart.cartItems![selectedProductIndex].product);

              Navigator.pushNamed(
                context,
                ShowProductDetailsPage.id,
              );
            },
          );
        } else if (state is EmptyCartState) {
          return const CustomEmptyBodyWidget(
            mainLabel: "Your Cart is Empty",
            subLabel:
                "Looks like you haven’t added any items to your cart yet.",
            buttonDescription: 'Shop Now',
            imageName: AppImages.imagesEmptyCart,
          );
        } else if (state is CartNoNetworkErrorState) {
          return CustomNoInternetConnectionBody(onTryAgainPressed: () {
            cartCubit.showCartAndPrice();
          });
        } else {
          return Container();
        }
      },
    );
  }
}
