import 'package:e_commerce_app/features/products/data/data_sources/get_home_details_service.dart';
import 'package:e_commerce_app/features/products/data/data_sources/get_product_by_category_service.dart';
import 'package:e_commerce_app/features/products/data/data_sources/get_product_details_service.dart';
import 'package:e_commerce_app/features/products/data/data_sources/search_in_products_service.dart';
import 'package:e_commerce_app/features/products/data/models/get_home_details_model.dart';
import 'package:e_commerce_app/features/products/data/models/get_product_response_model.dart';
import 'package:e_commerce_app/features/products/data/models/get_products_response_model.dart';
import 'package:e_commerce_app/features/products/data/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final GetHomeDetailsService getHomeDetailsService;
  final GetProductByCategoryService getProductByCategoryService;
  final SearchInProductsService searchInProductsService;
  final GetProductDetailsService getProductDetailsService;

  ProductRepositoryImpl({
    required this.getHomeDetailsService,
    required this.getProductByCategoryService,
    required this.searchInProductsService,
    required this.getProductDetailsService,
  });

  @override
  Future<GetHomeDetailsResponseModel> getHomeData() async {
    return await getHomeDetailsService.getHomeData();
  }

  @override
  Future<GetProductsCategoryResponseModel> getProductsByCategory({
    required int categoryId,
    Map<String, dynamic>? queryParams,
  }) async {
    return await getProductByCategoryService.getProductsByCategory(
      categoryId: categoryId,
      queryParams: queryParams,
    );
  }

  @override
  Future<GetProductsCategoryResponseModel> searchInProducts(
      {required int categoryId, required String productName}) async {
    return await searchInProductsService.searchInProducts(
        productName: productName, categoryId: categoryId);
  }

  @override
  Future<GetProductResponseModel> getProductDetails({required int productId}) async{
    return await getProductDetailsService.getProductDetails(productId: productId);
  }
}
