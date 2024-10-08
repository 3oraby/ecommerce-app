import 'package:e_commerce_app/features/auth/presentation/pages/verify_email_page.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/onboarding/presentation/pages/splash_page.dart';
import 'package:e_commerce_app/features/orders/presentation/pages/cancel_items_from_order_page.dart';
import 'package:e_commerce_app/features/orders/presentation/pages/order_confirmed_page.dart';
import 'package:e_commerce_app/features/orders/presentation/pages/show_order_summary_page.dart';
import 'package:e_commerce_app/features/orders/presentation/pages/tracking_order_details_page.dart';
import 'package:e_commerce_app/features/products/presentation/pages/apply_price_filter_page.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_filter_page.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_product_details_page.dart';
import 'package:e_commerce_app/features/products/presentation/pages/show_products_page.dart';
import 'package:e_commerce_app/features/reviews/presentation/pages/make_new_review_page.dart';
import 'package:e_commerce_app/features/reviews/presentation/pages/show_all_reviews_page.dart';
import 'package:e_commerce_app/features/user/presentation/pages/edit_user_profile_page.dart';
import 'package:e_commerce_app/features/user/presentation/pages/update_password_page.dart';
import 'package:e_commerce_app/features/address/presentation/pages/add_address_page.dart';
import 'package:e_commerce_app/features/address/presentation/pages/choose_address_page.dart';
import 'package:e_commerce_app/features/auth/presentation/pages/login_page.dart';
import 'package:e_commerce_app/features/auth/presentation/pages/register_page.dart';
import 'package:e_commerce_app/features/cart/presentation/pages/checkout_page.dart';
import 'package:e_commerce_app/features/auth/presentation/pages/entry_page.dart';
import 'package:flutter/material.dart';

import '../features/onboarding/presentation/pages/onboarding_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutesMap = {
  OnboardingPage.id: (context) => const OnboardingPage(),
  EntryPage.id: (context) => const EntryPage(),
  LoginPage.id: (context) => const LoginPage(),
  RegisterPage.id: (context) => const RegisterPage(),
  VerifyEmailPage.id: (context) => const VerifyEmailPage(),
  HomePage.id: (context) => const HomePage(),
  ShowProductDetailsPage.id: (context) => const ShowProductDetailsPage(),
  ShowProductsPage.id: (context) => const ShowProductsPage(),
  CheckoutPage.id: (context) => const CheckoutPage(),
  AddAddressPage.id: (context) => const AddAddressPage(),
  ChooseAddressPage.id: (context) => const ChooseAddressPage(),
  OrderConfirmedPage.id: (context) => const OrderConfirmedPage(),
  ShowAllReviewsPage.id: (context) => const ShowAllReviewsPage(),
  TrackingOrderDetailsPage.id: (context) => const TrackingOrderDetailsPage(),
  ShowOrderSummaryPage.id: (context) => const ShowOrderSummaryPage(),
  CancelItemsFromOrderPage.id: (context) => const CancelItemsFromOrderPage(),
  MakeNewReviewPage.id: (context) => const MakeNewReviewPage(),
  UpdatePasswordPage.id: (context) => const UpdatePasswordPage(),
  EditUserProfilePage.id: (context) => const EditUserProfilePage(),
  ShowFilterPage.id: (context) => const ShowFilterPage(),
  ApplyPriceFilterPage.id: (context) => const ApplyPriceFilterPage(),
  SplashPage.id: (context) => const SplashPage(),
};
