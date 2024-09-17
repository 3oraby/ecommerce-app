import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/widgets/custom_text_form_field.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/show_products_widgets/show_products_loaded_body.dart';

class ShowProductsPage extends StatefulWidget {
  const ShowProductsPage({super.key});
  static const String id = "showProductsPage";

  @override
  State<ShowProductsPage> createState() => _ShowProductsPageState();
}

class _ShowProductsPageState extends State<ShowProductsPage> {
  final TextEditingController productNameTextEditingController =
      TextEditingController();
  late int categoryId;
  late ProductCatalogCubit productCatalogCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryId = ModalRoute.of(context)!.settings.arguments as int;
    productCatalogCubit = BlocProvider.of<ProductCatalogCubit>(context);

    productCatalogCubit.getProductsByCategory(categoryId: categoryId);
  }

  @override
  Widget build(BuildContext context) {
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
        title: CustomTextFormFieldWidget(
          hintText: "Search for a product",
          borderWidth: 0,
          enabledBorderWidth: 0,
          borderColor: Colors.white,
          enabledBorderColor: Colors.white,
          suffixIcon: const Icon(
            Icons.search,
            color: Colors.black,
            size: 35,
          ),
          fillColor: Colors.white,
          hintStyle: const TextStyle(
            color: Colors.black,
          ),
          borderRadius: LocalConstants.kBorderRadius,
          focusedBorderColor: Colors.transparent,
          onChanged: (value) {
            // Trigger the search when the user types
            productCatalogCubit.searchInProducts(
                categoryId: categoryId, productName: value);
          },
        ),
      ),
      body: BlocBuilder<ProductCatalogCubit, ProductCatalogState>(
        builder: (context, state) {
          if (state is GetProductsByCategoryLoadingState ||
              state is SearchInProductsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetProductsByCategoryErrorState ||
              state is SearchInProductsErrorState) {
            return Center(
              child: Text((state as dynamic).message),
            );
          } else if (state is GetProductsByCategoryLoadedState ||
              state is SearchInProductsLoadedState) {
            return ShowProductsLoadedBody(
                products: (state as dynamic).products);
          } else {
            return const Center(
              child: Text("Cannot get products"),
            );
          }
        },
      ),
    );
  }
}
