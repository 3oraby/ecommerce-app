
import 'package:e_commerce_app/core/helpers/functions/check_connection_with_internet.dart';
import 'package:e_commerce_app/core/models/category_model.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/features/home/data/models/get_categories_response_model.dart';
import 'package:e_commerce_app/features/home/data/repositories/category_repository.dart';
import 'package:e_commerce_app/features/products/data/models/filter_arguments_model.dart';
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
  FilterArgumentsModel? _filterArgumentsModel;
  int? _selectedCategoryId;
  String _selectedSortOption = "Popularity";
  int? _totalPages;
  int? _currentPage;

  String get getSelectedSortOption => _selectedSortOption;

  void setSelectedSortOption(String option) {
    _selectedSortOption = option;
  }

  void setTotalPages(int totalPages) {
    _totalPages = totalPages;
  }

  void setCurrentPage(int currentPage) {
    _currentPage = currentPage;
  }

  void setSelectedProduct(ProductModel product) {
    _selectedProduct = product;
  }

  void setSelectedCategoryId(int category) {
    _selectedCategoryId = category;
  }

  void setFilterArgumentsAppliedModel(FilterArgumentsModel? filter) {
    _filterArgumentsModel = filter;
  }

  void resetFilterArgumentsAppliedModel() {
    _filterArgumentsModel = null;
  }

  ProductModel? get getSelectedProduct => _selectedProduct;
  int? get getSelectedCategoryId => _selectedCategoryId;
  FilterArgumentsModel? get getFilterArgumentsAppliedModel =>
      _filterArgumentsModel;

  int? get getTotalPages => _totalPages;
  int? get getCurrentPage => _currentPage;

  void refreshPage() {
    emit(ProductPageRefreshState());
  }

  Future<void> getCategories() async {
    if (!await checkConnectionWithInternet()) {
      emit(ProductNoInternetConnectionState());
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
        emit(GetHomeDataErrorState(message: e.toString()));
      }
    }
  }

  Future<void> getHomeData() async {
    if (!await checkConnectionWithInternet()) {
      emit(ProductNoInternetConnectionState());
    } else {
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
  }

  Future<void> getProductsByCategory({
    required int categoryId,
    Map<String, dynamic>? queryParams,
  }) async {
    if (!await checkConnectionWithInternet()) {
      emit(ProductNoInternetConnectionState());
    } else {
      emit(GetProductsByCategoryLoadingState());
      try {
        GetProductsCategoryResponseModel getProductsCategoryResponseModel =
            await productRepository.getProductsByCategory(
          categoryId: categoryId,
          queryParams: queryParams,
        );
        if (getProductsCategoryResponseModel.status) {
          setCurrentPage(getProductsCategoryResponseModel.currentPage!);
          setTotalPages(getProductsCategoryResponseModel.totalPages!);
          emit(GetProductsByCategoryLoadedState(
            products: getProductsCategoryResponseModel.products!,
            filterArgumentsModel:
                FilterArgumentsModel.fromJson(queryParams ?? {}),
          ));
        } else {
          emit(GetProductsByCategoryErrorState(
              message: getProductsCategoryResponseModel.message!));
        }
      } catch (e) {
        emit(GetProductsByCategoryErrorState(message: e.toString()));
      }
    }
  }

  Future<void> searchInProducts(
      {required int categoryId, required String productName}) async {
    if (!await checkConnectionWithInternet()) {
      emit(ProductNoInternetConnectionState());
    } else {
      emit(SearchInProductsLoadingState());
      try {
        GetProductsCategoryResponseModel getProductsCategoryResponseModel =
            await productRepository.searchInProducts(
          categoryId: categoryId,
          productName: productName,
        );
        if (getProductsCategoryResponseModel.status) {
          emit(SearchInProductsLoadedState(
              products: getProductsCategoryResponseModel.products!));
        } else {
          emit(SearchInProductsErrorState(
              message: getProductsCategoryResponseModel.message!));
        }
      } catch (e) {
        emit(SearchInProductsErrorState(message: e.toString()));
      }
    }
  }

  // Future<GetProductResponseModel?> getProductDetails(
  //     {required int productId}) async {
  //   if (!await checkConnectionWithInternet()) {
  //     emit(ProductNoInternetConnectionState());
  //   } else {
  //     try {
  //       return await productRepository.getProductDetails(productId: productId);
  //     } catch (e) {
  //       log(e.toString());
  //       throw Exception(e);
  //     }
  //   }
  // }
}
