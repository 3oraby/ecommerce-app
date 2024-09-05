
import 'package:e_commerce_app/features/home/data/models/get_categories_response_model.dart';

abstract class CategoryRepository {
  Future<GetCategoriesResponseModel> getCategories();
}