import 'package:device_preview/device_preview.dart';
import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/services/setup_get_it_service.dart';
import 'package:e_commerce_app/e_commerce_app.dart';
import 'package:e_commerce_app/features/address/data/repositories/addresses_repository.dart';
import 'package:e_commerce_app/features/address/presentation/cubit/addresses_cubit.dart';
import 'package:e_commerce_app/features/auth/data/repositories/auth_repository.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_commerce_app/features/cart/data/repositories/cart_repository.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/favorites/data/repositories/favorites_repository.dart';
import 'package:e_commerce_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce_app/features/home/data/repositories/category_repository.dart';
import 'package:e_commerce_app/features/orders/data/repositories/order_repository.dart';
import 'package:e_commerce_app/features/orders/presentation/cubit/order_cubit.dart';
import 'package:e_commerce_app/features/products/data/repositories/product_repository.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:e_commerce_app/features/reviews/data/repositories/review_repository.dart';
import 'package:e_commerce_app/features/reviews/presentation/cubit/review_cubit.dart';
import 'package:e_commerce_app/features/user/data/repositories/user_repository.dart';
import 'package:e_commerce_app/features/user/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesSingleton.init();
  bool isFirstTime = SharedPreferencesSingleton.getBool(
      LocalConstants.isOnBoardingSeenNameInPref);

  setupGetIt();
  // SharedPreferencesSingleton.deleteStringFromSharedPreferences(
  //     LocalConstants.userAddressModelInPref);
  // SharedPreferencesSingleton.deleteStringFromSharedPreferences(
  //     LocalConstants.userModelNameInPref);
  // SharedPreferencesSingleton.deleteStringFromSharedPreferences(
  //     LocalConstants.accessTokenNameInPref);
  // SharedPreferencesSingleton.deleteStringFromSharedPreferences(
  //     LocalConstants.refreshTokenNameInPref);
  runApp(
    DevicePreview(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(
              authRepository: getIt<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => FavoritesCubit(
              favoritesRepository: getIt<FavoritesRepository>(),
            ),
          ),
          // Addresses cubit
          BlocProvider(
            create: (context) => AddressesCubit(
              addressesRepository: getIt<AddressesRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => CartCubit(
              cartRepository: getIt<CartRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => UserCubit(
              userRepository: getIt<UserRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => OrderCubit(
              orderRepository: getIt<OrderRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ReviewCubit(
              reviewRepository: getIt<ReviewRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ProductCatalogCubit(
              productRepository: getIt<ProductRepository>(),
              categoryRepository: getIt<CategoryRepository>(),
            ),
          ),
        ],
        child: ECommerceApp(
          isOnBoardingSeen: isFirstTime,
        ),
      ),
    ),
  );
}
