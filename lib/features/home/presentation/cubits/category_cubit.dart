import 'package:e_commerce_app/core/helpers/functions/check_connection_with_internet.dart';
import 'package:e_commerce_app/features/home/data/models/get_categories_response_model.dart';
import 'package:e_commerce_app/features/home/data/repositories/category_repository.dart';
import 'package:e_commerce_app/features/home/presentation/cubits/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryCubit({required this.categoryRepository}) : super(CategoryInitial());

  Future<void> getCategories() async {
    if (!await checkConnectionWithInternet()) {
      emit(CategoryNoInternetConnectionState());
    } else {
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
        emit(GetCategoriesErrorState(message: e.toString()));
      }
    }
  }
}
