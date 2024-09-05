part of 'product_catalog_cubit.dart';

abstract class ProductCatalogState {}

final class ProductInitial extends ProductCatalogState {}

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