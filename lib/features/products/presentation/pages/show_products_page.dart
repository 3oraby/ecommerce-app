import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:e_commerce_app/core/widgets/custom_text_form_field.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_products_widgets/show_products_loaded_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowProductsPage extends StatefulWidget {
  const ShowProductsPage({super.key});
  static const String id = "showProductsPage";

  @override
  State<ShowProductsPage> createState() => _ShowProductsPageState();
}

class _ShowProductsPageState extends State<ShowProductsPage> {
  @override
  Widget build(BuildContext context) {
    int categoryId = ModalRoute.of(context)!.settings.arguments as int;

    BlocProvider.of<ProductCatalogCubit>(context)
        .getProductsByCategory(categoryId: categoryId);

    return Scaffold(
      backgroundColor: ThemeColors.backgroundBodiesColor,
      appBar: AppBar(
        backgroundColor: ThemeColors.backgroundBodiesColor,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const CustomTextFormFieldWidget(
          labelText: "Search for a product",
          borderWidth: 0,
          borderColor: Colors.white,
          enabledBorderColor: Colors.white,
          suffixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 35,
          ),
          fillColor: Colors.white,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          borderRadius: 35,
        ),
      ),
      body: BlocBuilder<ProductCatalogCubit, ProductCatalogState>(
        builder: (context, state) {
          if (state is GetProductsByCategoryLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetProductsByCategoryErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is GetProductsByCategoryLoadedState) {
            return ShowProductsLoadedBody(products: state.products);
          } 
          else {
            return const Center(
              child: Text("can not get all products"),
            );
          }
        },
      ),
    );
  }
}
