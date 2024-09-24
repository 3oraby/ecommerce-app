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
      // listenWhen: (previous, current) {
      //   return current is DeleteFromCartLoadingState ||
      //       current is DeleteFromCartErrorState ||
      //       current is CartNoNetworkErrorState;
      // },
      // listener: (context, state) {
      //   if (state is DeleteFromCartLoadingState) {
      //     setState(() {
      //       isDeleteItemLoading = true;
      //     });
      //   } else if (state is DeleteCartNoNetworkErrorState) {
      //     setState(() {
      //       isDeleteItemLoading = false;
      //     });
      //     showErrorWithInternetDialog(context);
      //   } else if (state is DeleteFromCartErrorState) {
      //     setState(() {
      //       isDeleteItemLoading = false;
      //     });
      //     showSnackBar(context, state.message);
      //   } else if (state is DeleteFromCartLoadedState) {
      //     setState(() {
      //       isDeleteItemLoading = false;
      //     });
      //   }
      // },
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
          return Container(
            height: 400,
            color: Colors.red,
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
          return const Center(
            child: Text("No items in your cart"),
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
