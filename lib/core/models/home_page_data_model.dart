
import 'package:e_commerce_app/core/models/product_model.dart';

class HomePageDataModel {
  final int categoryId;
  final String categoryName;
  final String categoryPhoto;
  final List<ProductModel> products;

  HomePageDataModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryPhoto,
    required this.products,
  });

  factory HomePageDataModel.fromJson({required Map<String, dynamic> json}) {
    List products = json["products"];
    return HomePageDataModel(
      categoryId: json["category_id"],
      categoryName: json["category_name"],
      categoryPhoto: json["category_photo"],
      products: products
          .map(
            (productJson) => ProductModel.fromJson(json: productJson),
          )
          .toList(),
    );
  }
}
