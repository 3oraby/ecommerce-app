import 'package:e_commerce_app/features/products/data/data_sources/get_home_details_service.dart';
import 'package:e_commerce_app/features/products/data/data_sources/get_product_by_category_service.dart';
import 'package:e_commerce_app/features/products/data/models/get_home_details_model.dart';
import 'package:e_commerce_app/features/products/data/models/get_products_response_model.dart';
import 'package:e_commerce_app/features/products/data/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final GetHomeDetailsService getHomeDetailsService;
  final GetProductByCategoryService getProductByCategoryService;

  ProductRepositoryImpl({
    required this.getHomeDetailsService,
    required this.getProductByCategoryService,
  });

  @override
  Future<GetHomeDetailsResponseModel> getHomeData() async {
    return await getHomeDetailsService.getHomeData();
  }

  @override
  Future<GetProductsCategoryResponseModel> getProductsByCategory(
      {required int categoryId}) async {
    return await getProductByCategoryService.getProductsByCategory(
        categoryId: categoryId);
  }
}
