import 'package:e_commerce_app/features/address/data/data_sources/get_all_addresses_service.dart';
import 'package:e_commerce_app/features/address/data/repositories/addresses_repository_impl.dart';
import 'package:e_commerce_app/features/address/presentation/cubit/addresses_cubit.dart';
import 'package:e_commerce_app/features/address/presentation/pages/add_address_page.dart';
import 'package:e_commerce_app/features/address/presentation/pages/choose_address_page.dart';
import 'package:e_commerce_app/features/auth/presentation/pages/register_page.dart';
import 'package:e_commerce_app/features/cart/presentation/pages/checkout_page.dart';
import 'package:e_commerce_app/features/favorites/data/data_sources/add_or_delete_favorite_service.dart';
import 'package:e_commerce_app/features/favorites/data/data_sources/get_favorites_service.dart';
import 'package:e_commerce_app/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:e_commerce_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:e_commerce_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_product_details_page.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_products_page.dart';
import 'package:e_commerce_app/features/user/presentation/pages/user_profile_page.dart';
import 'package:e_commerce_app/features/entry/presentation/pages/entry_page.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/auth/presentation/pages/login_page.dart';
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
      ],
      child: ECommerceApp(
        isFirstTime: isFirstTime,
      ),
    ),
  );
}

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({
    super.key,
    required this.isFirstTime,
  });

  final bool isFirstTime;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        OnboardingPage.id: (context) => const OnboardingPage(),
        EntryPage.id: (context) => const EntryPage(),
        LoginPage.id: (context) => const LoginPage(),
        RegisterPage.id: (context) => const RegisterPage(),
        HomePage.id: (context) => const HomePage(),
        UserProfilePage.id: (context) => const UserProfilePage(),
        ShowProductDetailsPage.id: (context) => const ShowProductDetailsPage(),
        ShowProductsPage.id: (context) => const ShowProductsPage(),
        CheckoutPage.id: (context) => const CheckoutPage(),
        AddAddressPage.id: (context) => const AddAddressPage(),
        ChooseAddressPage.id: (context) => const ChooseAddressPage(),
      },
      initialRoute: isFirstTime ? OnboardingPage.id : EntryPage.id,
    );
  }
}
