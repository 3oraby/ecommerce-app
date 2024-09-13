import 'package:e_commerce_app/e_commerce_app.dart';
import 'package:e_commerce_app/features/address/data/data_sources/get_all_addresses_service.dart';
import 'package:e_commerce_app/features/address/data/data_sources/get_all_orders_addresses_service.dart';
import 'package:e_commerce_app/features/address/data/repositories/addresses_repository_impl.dart';
import 'package:e_commerce_app/features/address/presentation/cubit/addresses_cubit.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/add_to_cart_service.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/check_product_in_cart_service.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/delete_from_cart_service.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/show_cart_item_service.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/show_cart_price_service.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/show_cart_service.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/update_cart_item_service.dart';
import 'package:e_commerce_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/favorites/data/data_sources/add_or_delete_favorite_service.dart';
import 'package:e_commerce_app/features/favorites/data/data_sources/get_favorites_service.dart';
import 'package:e_commerce_app/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:e_commerce_app/features/favorites/presentation/cubit/favorites_cubit.dart';

import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce_app/features/home/data/data_sources/get_categories_service.dart';
import 'package:e_commerce_app/features/home/data/repositories/category_repository_impl.dart';
import 'package:e_commerce_app/features/orders/data/data_sources/cancel_item_from_order_service.dart';
import 'package:e_commerce_app/features/orders/data/data_sources/checkout_service.dart';
import 'package:e_commerce_app/features/orders/data/data_sources/get_all_orders_service.dart';
import 'package:e_commerce_app/features/orders/data/data_sources/get_order_data_service.dart';
import 'package:e_commerce_app/features/orders/data/repositories/order_repository_impl.dart';
import 'package:e_commerce_app/features/orders/presentation/cubit/order_cubit.dart';
import 'package:e_commerce_app/features/products/data/data_sources/get_home_details_service.dart';
import 'package:e_commerce_app/features/products/data/data_sources/get_product_by_category_service.dart';
import 'package:e_commerce_app/features/products/data/repositories/product_repository_impl.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:e_commerce_app/features/reviews/data/data_sources/create_review_service.dart';
import 'package:e_commerce_app/features/reviews/data/data_sources/delete_review_service.dart';
import 'package:e_commerce_app/features/reviews/data/data_sources/get_product_average_rating_service.dart';
import 'package:e_commerce_app/features/reviews/data/data_sources/get_product_reviews_service.dart';
import 'package:e_commerce_app/features/reviews/data/data_sources/get_review_service.dart';
import 'package:e_commerce_app/features/reviews/data/data_sources/update_review_service.dart';
import 'package:e_commerce_app/features/reviews/data/repositories/review_repository_impl.dart';
import 'package:e_commerce_app/features/reviews/presentation/cubit/review_cubit.dart';
import 'package:e_commerce_app/features/user/data/data_sources/get_user_service.dart';
import 'package:e_commerce_app/features/user/data/data_sources/update_user_service.dart';
import 'package:e_commerce_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:e_commerce_app/features/user/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesSingleton.init();
  bool isFirstTime = SharedPreferencesSingleton.getBool("isFirstTime");
  runApp(
    MultiBlocProvider(
      providers: [
        // favorites cubit
        BlocProvider(
          create: (context) => FavoritesCubit(
            favoritesRepository: FavoritesRepositoryImpl(
              getFavoritesService: GetFavoritesService(),
              addOrDeleteFavoritesService: AddOrDeleteFavoritesService(),
            ),
          ),
        ),
        // Addresses cubit
        BlocProvider(
          create: (context) => AddressesCubit(
            addressesRepository: AddressesRepositoryImpl(
              getAllAddressesService: GetAllAddressesService(),
              getAllOrdersAddressesService: GetAllOrdersAddressesService(),
            ),
          ),
        ),
        // cart cubit
        BlocProvider(
          create: (context) => CartCubit(
            cartRepository: CartRepositoryImpl(
              addToCartService: AddToCartService(),
              deleteFromCartService: DeleteFromCartService(),
              showCartPriceService: ShowCartPriceService(),
              showCartService: ShowCartService(),
              showCartItemService: ShowCartItemService(),
              updateCartItemService: UpdateCartItemService(),
              checkProductInCartService: CheckProductInCartService(),
            ),
          ),
        ),
        // user cubit
        BlocProvider(
          create: (context) => UserCubit(
            userRepository: UserRepositoryImpl(
              getUserService: GetUserService(),
              updateUserService: UpdateUserService(),
            ),
          ),
        ),
        // order cubit
        BlocProvider(
          create: (context) => OrderCubit(
            orderRepository: OrderRepositoryImpl(
              checkoutService: CheckoutService(),
              getOrderDataService: GetOrderDataService(),
              getAllOrdersService: GetAllOrdersService(),
              cancelItemFromOrderService: CancelItemFromOrderService(),
            ),
          ),
        ),
        // review cubit
        BlocProvider(
          create: (context) => ReviewCubit(
            reviewRepository: ReviewRepositoryImpl(
              createReviewService: CreateReviewService(),
              deleteReviewService: DeleteReviewService(),
              getProductAverageRatingService: GetProductAverageRatingService(),
              getProductReviewsService: GetProductReviewsService(),
              getReviewService: GetReviewService(),
              updateReviewService: UpdateReviewService(),
            ),
          ),
        ),
        // product cubit
        BlocProvider(
          create: (context) => ProductCatalogCubit(
            productRepository: ProductRepositoryImpl(
              getHomeDetailsService: GetHomeDetailsService(),
              getProductByCategoryService: GetProductByCategoryService(),
            ),
            categoryRepository: CategoryRepositoryImpl(
              getCategoriesService: GetCategoriesService(),
            ),
          ),
        ),
      ],
      child: ECommerceApp(
        isFirstTime: isFirstTime,
      ),
    ),
  );
}
