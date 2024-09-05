import 'package:e_commerce_app/features/home/data/data_sources/get_categories_service.dart';
import 'package:e_commerce_app/features/home/data/models/get_categories_response_model.dart';
import 'package:e_commerce_app/features/home/data/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final GetCategoriesService getCategoriesService;

  CategoryRepositoryImpl({required this.getCategoriesService});

  @override
  Future<GetCategoriesResponseModel> getCategories() async {
    return await getCategoriesService.getCategories();
  }
}
