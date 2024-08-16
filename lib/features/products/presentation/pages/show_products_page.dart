import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/custom_main_product_card.dart';
import 'package:e_commerce_app/features/products/data/data_sources/get_product_by_category_service.dart';
import 'package:e_commerce_app/features/products/data/models/get_products_response_model.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_product_details_page.dart';
import 'package:e_commerce_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: ThemeColors.backgroundBodiesColor,
      appBar: AppBar(
        backgroundColor: ThemeColors.backgroundBodiesColor,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 48,
        ),
        child: FutureBuilder(
          future: GetProductByCategoryService()
              .getProductsByCategory(categoryId: categoryId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              GetProductsCategoryResponseModel data = snapshot.data!;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 48,
                  childAspectRatio: 0.5,
                ),
                itemCount: data.products!.length,
                itemBuilder: (context, index) => Transform.translate(
                  offset: Offset(
                      0,
                      index.isOdd
                          ? 36
                          : 0), // shift the right products to bottom
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ShowProductDetailsPage.id,
                        arguments: data.products![index],
                      );
                    },
                    child: CustomMainProductCard(
                      productModel: data.products![index],
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Container(
                height: 400,
                color: Colors.orange,
              );
            } else {
              return Container(
                height: 400,
                color: Colors.amber,
              );
            }
          },
        ),
      ),
    );
  }
}
