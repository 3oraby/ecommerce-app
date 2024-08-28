
import 'package:e_commerce_app/features/address/presentation/pages/add_address_page.dart';
import 'package:e_commerce_app/features/address/presentation/pages/choose_address_page.dart';
import 'package:e_commerce_app/features/auth/presentation/pages/login_page.dart';
import 'package:e_commerce_app/features/auth/presentation/pages/register_page.dart';
import 'package:e_commerce_app/features/cart/presentation/pages/checkout_page.dart';
import 'package:e_commerce_app/features/entry/presentation/pages/entry_page.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_product_details_page.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_products_page.dart';
import 'package:e_commerce_app/features/user/presentation/pages/user_profile_page.dart';
import 'package:flutter/material.dart';

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
