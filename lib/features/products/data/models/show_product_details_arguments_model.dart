import 'package:e_commerce_app/core/models/product_model.dart';

class ShowProductDetailsArgumentsModel {
  final String lastPageId;
  final ProductModel productModel;

  ShowProductDetailsArgumentsModel({
    required this.lastPageId,
    required this.productModel,
  });
}
