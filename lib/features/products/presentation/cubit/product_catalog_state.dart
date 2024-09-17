part of 'product_catalog_cubit.dart';

abstract class ProductCatalogState {}

final class ProductInitial extends ProductCatalogState {}

final class ProductPageRefreshState extends ProductCatalogState {}

final class GetHomeDataLoadingState extends ProductCatalogState {}

final class GetHomeDataLoadedState extends ProductCatalogState {
  final GetHomeDetailsResponseModel getHomeDetailsResponseModel;

  GetHomeDataLoadedState({required this.getHomeDetailsResponseModel});
}

final class GetHomeDataErrorState extends ProductCatalogState {
  final String message;

  GetHomeDataErrorState({required this.message});
}

final class GetCategoriesLoadingState extends ProductCatalogState {}

final class GetCategoriesLoadedState extends ProductCatalogState {
  final List<CategoryModel> categories;
  GetCategoriesLoadedState({required this.categories});
}

final class GetCategoriesErrorState extends ProductCatalogState {
  final String message;
  GetCategoriesErrorState({required this.message});
}

final class GetProductsByCategoryLoadingState extends ProductCatalogState {}

final class GetProductsByCategoryLoadedState extends ProductCatalogState {
  final List<ProductModel> products;
  GetProductsByCategoryLoadedState({required this.products});
}

final class GetProductsByCategoryErrorState extends ProductCatalogState {
  final String message;
  GetProductsByCategoryErrorState({required this.message});
}


final class SearchInProductsLoadingState extends ProductCatalogState {}

final class SearchInProductsLoadedState extends ProductCatalogState {
  final List<ProductModel> products;
  SearchInProductsLoadedState({required this.products});
}

final class SearchInProductsErrorState extends ProductCatalogState {
  final String message;
  SearchInProductsErrorState({required this.message});
}


