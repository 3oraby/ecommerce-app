part of 'product_catalog_cubit.dart';

abstract class ProductCatalogState {}

final class ProductInitial extends ProductCatalogState {}

final class ProductPageRefreshState extends ProductCatalogState {}

final class ProductNoInternetConnectionState extends ProductCatalogState {}

final class GetHomeDataLoadingState extends ProductCatalogState {}

final class GetHomeDataLoadedState extends ProductCatalogState {
  final GetHomeDetailsResponseModel getHomeDetailsResponseModel;

  GetHomeDataLoadedState({required this.getHomeDetailsResponseModel});
}

final class GetHomeDataErrorState extends ProductCatalogState {
  final String message;

  GetHomeDataErrorState({required this.message});
}

final class GetProductsByCategoryLoadedState extends ProductCatalogState {
  final List<ProductModel> products;
  final FilterArgumentsModel filterArgumentsModel;
  GetProductsByCategoryLoadedState({
    required this.products,
    required this.filterArgumentsModel,
  });
}

final class GetProductsByCategoryLoadingState extends ProductCatalogState {}

final class GetProductsByCategoryEmptyState extends ProductCatalogState {}

final class GetProductsByCategoryErrorState extends ProductCatalogState {
  final String message;
  GetProductsByCategoryErrorState({required this.message});
}

final class SearchInProductsLoadingState extends ProductCatalogState {}

final class SearchInProductsEmptyState extends ProductCatalogState {}

final class SearchInProductsLoadedState extends ProductCatalogState {
  final List<ProductModel> products;
  SearchInProductsLoadedState({required this.products});
}

final class SearchInProductsErrorState extends ProductCatalogState {
  final String message;
  SearchInProductsErrorState({required this.message});
}
