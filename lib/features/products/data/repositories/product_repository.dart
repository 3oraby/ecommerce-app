import 'package:e_commerce_app/features/products/data/models/get_home_details_model.dart';
import 'package:e_commerce_app/features/products/data/models/get_products_response_model.dart';

abstract class ProductRepository {
  Future<GetHomeDetailsResponseModel> getHomeData();

  Future<GetProductsCategoryResponseModel> getProductsByCategory({
    required int categoryId,
  });
  
}
