import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/cart_app_bar.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/cart_body.dart';
import 'package:e_commerce_app/features/favorites/presentation/widgets/favorites_app_bar.dart';
import 'package:e_commerce_app/features/favorites/presentation/widgets/favorites_body.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/home_app_bar.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/my_orders_app_bar.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/my_orders_body.dart';
import 'package:e_commerce_app/features/settings/presentation/widgets/settings_app_bar.dart';

import 'package:e_commerce_app/features/home/presentation/widgets/home_body.dart';
import 'package:e_commerce_app/features/settings/presentation/widgets/settings_body.dart';
import 'package:flutter/material.dart';

class AppPageManager {
  final UserModel userModel;

  AppPageManager({
    required this.userModel,
  });

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

  AppBar getAppBar(int index, BuildContext context) {
    switch (index) {
      case 0:
        return HomeAppBar.getHomeAppBar(context: context);
      case 1:
        return MyOrdersAppBar.getMyOrdersAppBar();
      case 2:
        return FavoritesAppBar.getFavoritesAppBar();
      case 3:
        return CartAppBar.getCartAppBar();
      case 4:
        return SettingsAppBar.getSettingsAppBar();
      default:
        return HomeAppBar.getHomeAppBar(context: context);
    }
  }
}
