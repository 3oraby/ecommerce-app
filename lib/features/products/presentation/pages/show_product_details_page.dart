import 'package:e_commerce_app/core/utils/navigation/home_page_navigation_service.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_state.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/products/data/models/show_product_details_arguments_model.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_product_details_widgets/show_products_details_loaded_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowProductDetailsPage extends StatelessWidget {
  const ShowProductDetailsPage({super.key});
  static const id = "showProductDetailsPage";

  @override
  Widget build(BuildContext context) {
    ShowProductDetailsArgumentsModel showProductDetailsArgumentsModel =
        ModalRoute.of(context)!.settings.arguments
            as ShowProductDetailsArgumentsModel;

    ProductModel productModel = showProductDetailsArgumentsModel.productModel;
    String lastPageId = showProductDetailsArgumentsModel.lastPageId;

    BlocProvider.of<CartCubit>(context).checkProductInCart(productModel.id);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "product Details",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              lastPageId,
              (Route<dynamic> route) => false,
            );
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
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartErrorState) {
            return Center(
              child: Container(
                color: Colors.red,
              ),
            );
          } else if (state is CheckProductInCartLoadedState) {
            return ShowProductsDetailsLoadedBody(
              productModel: productModel,
              inCart: state.inCart,
              productQuantityInCart: state.productQuantityInCart,
            );
          } else if (state is CartLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
