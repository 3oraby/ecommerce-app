import 'package:e_commerce_app/core/models/category_model.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/features/home/data/models/get_categories_response_model.dart';
import 'package:e_commerce_app/features/home/data/repositories/category_repository.dart';
import 'package:e_commerce_app/features/products/data/models/get_home_details_model.dart';
import 'package:e_commerce_app/features/products/data/models/get_products_response_model.dart';
import 'package:e_commerce_app/features/products/data/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_catalog_state.dart';

class ProductCatalogCubit extends Cubit<ProductCatalogState> {
  ProductCatalogCubit({
    required this.productRepository,
    required this.categoryRepository,
  }) : super(ProductInitial());

  final ProductRepository productRepository;
  final CategoryRepository categoryRepository;
  ProductModel? _selectedProduct;

  void setSelectedProduct(ProductModel product) {
    _selectedProduct = product;
  }

  ProductModel? get getSelectedProduct => _selectedProduct;

  void refreshPage(){
    emit(ProductPageRefreshState());
  }

  Future<void> getCategories() async {
    emit(GetCategoriesLoadingState());
    try {
      GetCategoriesResponseModel getCategoriesResponseModel =
          await categoryRepository.getCategories();
      if (getCategoriesResponseModel.status) {
        emit(GetCategoriesLoadedState(
            categories: getCategoriesResponseModel.categories!));
      } else {
        emit(GetCategoriesErrorState(
            message: getCategoriesResponseModel.message!));
      }
    } catch (e) {
      emit(GetHomeDataErrorState(message: e.toString()));
    }
  }

  Future<void> getHomeData() async {
    emit(GetHomeDataLoadingState());
    try {
      GetHomeDetailsResponseModel getHomeDetailsResponseModel =
          await productRepository.getHomeData();
      if (getHomeDetailsResponseModel.status) {
        emit(GetHomeDataLoadedState(
            getHomeDetailsResponseModel: getHomeDetailsResponseModel));
      } else {
        emit(GetHomeDataErrorState(
            message: getHomeDetailsResponseModel.message!));
      }
    } catch (e) {
      emit(GetHomeDataErrorState(message: e.toString()));
    }
  }

  Future<void> getProductsByCategory({required int categoryId}) async {
    emit(GetProductsByCategoryLoadingState());
    try {
      GetProductsCategoryResponseModel getProductsCategoryResponseModel =
          await productRepository.getProductsByCategory(categoryId: categoryId);
      if (getProductsCategoryResponseModel.status) {
        emit(GetProductsByCategoryLoadedState(
            products: getProductsCategoryResponseModel.products!));
      } else {
        emit(GetProductsByCategoryErrorState(
            message: getProductsCategoryResponseModel.message!));
      }
    } catch (e) {
      emit(GetProductsByCategoryErrorState(message: e.toString()));
    }
  }
}
