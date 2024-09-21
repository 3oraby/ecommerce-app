import 'package:e_commerce_app/features/products/data/models/get_home_details_model.dart';
import 'package:e_commerce_app/features/products/data/models/get_product_response_model.dart';
import 'package:e_commerce_app/features/products/data/models/get_products_response_model.dart';

abstract class ProductRepository {
  Future<GetHomeDetailsResponseModel> getHomeData();

  Future<GetProductsCategoryResponseModel> getProductsByCategory({
    required int categoryId,
    Map<String,dynamic> ?queryParams,

  });

  Future<GetProductsCategoryResponseModel> searchInProducts({
    required int categoryId,
    required String productName,
  });

  Future<GetProductResponseModel> getProductDetails({
    required int productId,
  });
}
