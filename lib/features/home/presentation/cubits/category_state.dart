import 'package:e_commerce_app/core/models/category_model.dart';

abstract class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryNoInternetConnectionState extends CategoryState {}
final class GetCategoriesLoadingState extends CategoryState {}

final class GetCategoriesLoadedState extends CategoryState {
  final List<CategoryModel> categories;
  GetCategoriesLoadedState({required this.categories});
}

final class GetCategoriesErrorState extends CategoryState {
  final String message;
  GetCategoriesErrorState({required this.message});
}

