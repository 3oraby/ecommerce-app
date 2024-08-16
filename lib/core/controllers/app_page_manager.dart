import 'package:e_commerce_app/features/home/presentation/widgets/app_bars/cart_app_bar.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/app_bars/favorites_app_bar.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/app_bars/home_app_bar.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/app_bars/my_orders_app_bar.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/app_bars/settings_app_bar.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/bodies/cart_body.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/bodies/favorites_body.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/bodies/home_body.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/bodies/my_orders_body.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/bodies/settings_body.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:flutter/material.dart';

class AppPageManager {
  final UserModel userModel;

  AppPageManager({required this.userModel});

  // Method to get the appropriate body based on the index
  Widget getPage(int index) {
    switch (index) {
      case 0:
        return const HomeBody();
      case 1:
        return const MyOrdersBody();
      case 2:
        return const FavoritesBody();
      case 3:
        return const CartBody();
      case 4:
        return const SettingsBody();
      default:
        return const HomeBody();
    }
  }

  // Method to get the appropriate app bar based on the index
  AppBar getAppBar(int index, BuildContext context) {
    switch (index) {
      case 0:
        return HomeAppBar.getHomeAppBar(userModel: userModel, context: context);
      case 1:
        return MyOrdersAppBar.getMyOrdersAppBar();
      case 2:
        return FavoritesAppBar.getFavoritesAppBar();
      case 3:
        return CartAppBar.getCartAppBar();
      case 4:
        return SettingsAppBar.getSettingsAppBar();
      default:
        return HomeAppBar.getHomeAppBar(userModel: userModel, context: context);
    }
  }
}
