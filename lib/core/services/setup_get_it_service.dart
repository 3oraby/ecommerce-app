import 'package:e_commerce_app/features/address/data/data_sources/get_all_addresses_service.dart';
import 'package:e_commerce_app/features/address/data/data_sources/get_all_orders_addresses_service.dart';
import 'package:e_commerce_app/features/address/data/repositories/addresses_repository.dart';
import 'package:e_commerce_app/features/address/data/repositories/addresses_repository_impl.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/log_out_service.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/login_service.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/register_service.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/verify_email_service.dart';
import 'package:e_commerce_app/features/auth/data/repositories/auth_repository.dart';
import 'package:e_commerce_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/add_to_cart_service.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/check_product_in_cart_service.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/delete_from_cart_service.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/show_cart_item_service.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/show_cart_price_service.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/show_cart_service.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/update_cart_item_service.dart';
import 'package:e_commerce_app/features/cart/data/repositories/cart_repository.dart';
import 'package:e_commerce_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:e_commerce_app/features/favorites/data/data_sources/add_or_delete_favorite_service.dart';
import 'package:e_commerce_app/features/favorites/data/data_sources/get_favorites_service.dart';
import 'package:e_commerce_app/features/favorites/data/repositories/favorites_repository.dart';
import 'package:e_commerce_app/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:e_commerce_app/features/home/data/data_sources/get_categories_service.dart';
import 'package:e_commerce_app/features/home/data/repositories/category_repository.dart';
import 'package:e_commerce_app/features/home/data/repositories/category_repository_impl.dart';
import 'package:e_commerce_app/features/orders/data/data_sources/cancel_item_from_order_service.dart';
import 'package:e_commerce_app/features/orders/data/data_sources/checkout_service.dart';
import 'package:e_commerce_app/features/orders/data/data_sources/get_all_orders_service.dart';
import 'package:e_commerce_app/features/orders/data/data_sources/get_order_data_service.dart';
import 'package:e_commerce_app/features/orders/data/repositories/order_repository.dart';
import 'package:e_commerce_app/features/orders/data/repositories/order_repository_impl.dart';
import 'package:e_commerce_app/features/products/data/data_sources/get_home_details_service.dart';
import 'package:e_commerce_app/features/products/data/data_sources/get_product_by_category_service.dart';
import 'package:e_commerce_app/features/products/data/data_sources/get_product_details_service.dart';
import 'package:e_commerce_app/features/products/data/data_sources/search_in_products_service.dart';
import 'package:e_commerce_app/features/products/data/repositories/product_repository.dart';
import 'package:e_commerce_app/features/products/data/repositories/product_repository_impl.dart';
import 'package:e_commerce_app/features/reviews/data/data_sources/check_user_review_for_product_service.dart';
import 'package:e_commerce_app/features/reviews/data/data_sources/create_review_service.dart';
import 'package:e_commerce_app/features/reviews/data/data_sources/delete_review_service.dart';
import 'package:e_commerce_app/features/reviews/data/data_sources/get_product_average_rating_service.dart';
import 'package:e_commerce_app/features/reviews/data/data_sources/get_product_reviews_service.dart';
import 'package:e_commerce_app/features/reviews/data/data_sources/get_review_service.dart';
import 'package:e_commerce_app/features/reviews/data/data_sources/update_review_service.dart';
import 'package:e_commerce_app/features/reviews/data/repositories/review_repository.dart';
import 'package:e_commerce_app/features/reviews/data/repositories/review_repository_impl.dart';
import 'package:e_commerce_app/features/user/data/data_sources/get_user_service.dart';
import 'package:e_commerce_app/features/user/data/data_sources/update_user_password_service.dart';
import 'package:e_commerce_app/features/user/data/data_sources/update_user_service.dart';
import 'package:e_commerce_app/features/user/data/repositories/user_repository.dart';
import 'package:e_commerce_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<LogOutService>(LogOutService());
  getIt.registerSingleton<LoginService>(LoginService());
  getIt.registerSingleton<RegisterService>(RegisterService());
  getIt.registerSingleton<VerifyEmailService>(VerifyEmailService());

  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      logOutService: getIt<LogOutService>(),
      loginService: getIt<LoginService>(),
      registerService: getIt<RegisterService>(),
      verifyEmailService: getIt<VerifyEmailService>(),
    ),
  );

  getIt.registerSingleton<GetAllAddressesService>(GetAllAddressesService());
  getIt.registerSingleton<GetAllOrdersAddressesService>(
      GetAllOrdersAddressesService());

  getIt.registerSingleton<AddressesRepository>(
    AddressesRepositoryImpl(
      getAllAddressesService: getIt<GetAllAddressesService>(),
      getAllOrdersAddressesService: getIt<GetAllOrdersAddressesService>(),
    ),
  );

  getIt.registerSingleton<AddToCartService>(AddToCartService());
  getIt.registerSingleton<CheckProductInCartService>(
      CheckProductInCartService());
  getIt.registerSingleton<DeleteFromCartService>(DeleteFromCartService());
  getIt.registerSingleton<ShowCartItemService>(ShowCartItemService());
  getIt.registerSingleton<ShowCartPriceService>(ShowCartPriceService());
  getIt.registerSingleton<ShowCartService>(ShowCartService());
  getIt.registerSingleton<UpdateCartItemService>(UpdateCartItemService());

  getIt.registerSingleton<CartRepository>(
    CartRepositoryImpl(
      addToCartService: getIt<AddToCartService>(),
      deleteFromCartService: getIt<DeleteFromCartService>(),
      showCartPriceService: getIt<ShowCartPriceService>(),
      showCartService: getIt<ShowCartService>(),
      showCartItemService: getIt<ShowCartItemService>(),
      updateCartItemService: getIt<UpdateCartItemService>(),
      checkProductInCartService: getIt<CheckProductInCartService>(),
    ),
  );

  getIt.registerSingleton<AddOrDeleteFavoritesService>(
      AddOrDeleteFavoritesService());
  getIt.registerSingleton<GetFavoritesService>(GetFavoritesService());

  getIt.registerSingleton<FavoritesRepository>(
    FavoritesRepositoryImpl(
      getFavoritesService: getIt<GetFavoritesService>(),
      addOrDeleteFavoritesService: getIt<AddOrDeleteFavoritesService>(),
    ),
  );

  getIt.registerSingleton<GetCategoriesService>(GetCategoriesService());
  getIt.registerSingleton<CategoryRepository>(CategoryRepositoryImpl(
      getCategoriesService: getIt<GetCategoriesService>()));

  getIt.registerSingleton<GetHomeDetailsService>(GetHomeDetailsService());
  getIt.registerSingleton<GetProductByCategoryService>(
      GetProductByCategoryService());
  getIt.registerSingleton<SearchInProductsService>(SearchInProductsService());
  getIt.registerSingleton<GetProductDetailsService>(GetProductDetailsService());

  getIt.registerSingleton<ProductRepository>(
    ProductRepositoryImpl(
      getHomeDetailsService: getIt<GetHomeDetailsService>(),
      getProductByCategoryService: getIt<GetProductByCategoryService>(),
      searchInProductsService: getIt<SearchInProductsService>(),
      getProductDetailsService: getIt<GetProductDetailsService>(),
    ),
  );

  getIt.registerSingleton<GetProductReviewsService>(GetProductReviewsService());
  getIt.registerSingleton<GetReviewService>(GetReviewService());
  getIt.registerSingleton<DeleteReviewService>(DeleteReviewService());
  getIt.registerSingleton<UpdateReviewService>(UpdateReviewService());
  getIt.registerSingleton<CreateReviewService>(CreateReviewService());
  getIt.registerSingleton<GetProductAverageRatingService>(
      GetProductAverageRatingService());
  getIt.registerSingleton<CheckUserReviewForProductService>(
      CheckUserReviewForProductService());

  getIt.registerSingleton<ReviewRepository>(
    ReviewRepositoryImpl(
      getProductReviewsService: getIt<GetProductReviewsService>(),
      getReviewService: getIt<GetReviewService>(),
      deleteReviewService: getIt<DeleteReviewService>(),
      updateReviewService: getIt<UpdateReviewService>(),
      createReviewService: getIt<CreateReviewService>(),
      getProductAverageRatingService: getIt<GetProductAverageRatingService>(),
      checkUserReviewForProductService:
          getIt<CheckUserReviewForProductService>(),
    ),
  );

  getIt.registerSingleton<CheckoutService>(CheckoutService());
  getIt.registerSingleton<GetOrderDataService>(GetOrderDataService());
  getIt.registerSingleton<GetAllOrdersService>(GetAllOrdersService());
  getIt.registerSingleton<CancelItemFromOrderService>(
      CancelItemFromOrderService());

  getIt.registerSingleton<OrderRepository>(
    OrderRepositoryImpl(
      checkoutService: getIt<CheckoutService>(),
      getOrderDataService: getIt<GetOrderDataService>(),
      getAllOrdersService: getIt<GetAllOrdersService>(),
      cancelItemFromOrderService: getIt<CancelItemFromOrderService>(),
    ),
  );

  getIt.registerSingleton<GetUserService>(GetUserService());
  getIt.registerSingleton<UpdateUserService>(UpdateUserService());
  getIt.registerSingleton<UpdateUserPasswordService>(
      UpdateUserPasswordService());

  getIt.registerSingleton<UserRepository>(
    UserRepositoryImpl(
      getUserService: getIt<GetUserService>(),
      updateUserService: getIt<UpdateUserService>(),
      updateUserPasswordService: getIt<UpdateUserPasswordService>(),
    ),
  );
}
