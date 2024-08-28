import 'package:e_commerce_app/e_commerce_app.dart';
import 'package:e_commerce_app/features/address/data/data_sources/get_all_addresses_service.dart';
import 'package:e_commerce_app/features/address/data/repositories/addresses_repository_impl.dart';
import 'package:e_commerce_app/features/address/presentation/cubit/addresses_cubit.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/add_to_cart_service.dart';
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
