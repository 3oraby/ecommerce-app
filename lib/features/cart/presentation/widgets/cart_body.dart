import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_state.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/cart_body_widgets/cart_body_loaded.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBody extends StatelessWidget {
  const CartBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductCatalogCubit productCatalogCubit =
        BlocProvider.of<ProductCatalogCubit>(context);
    final CartCubit cartCubit = BlocProvider.of<CartCubit>(context);
    cartCubit.showCartAndPrice();

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is ShowCartLoadingState) {
          return const Center(child: CircularProgressIndicator());
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
            onProductTap: (selectedProductIndex) async {
              productCatalogCubit.setSelectedProduct(
                  state.cart.cartItems![selectedProductIndex].product);

              final isRefresh = await Navigator.pushNamed(
                context,
                ShowProductDetailsPage.id,
              );
              if (isRefresh is bool && isRefresh) {
                cartCubit.showCartAndPrice();
              }
            },
          );
        } else if (state is EmptyCartState) {
          return const Center(
            child: Text("No items in your cart"),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
