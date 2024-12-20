import 'package:e_commerce_app/core/models/bottom_navigation_bar_model.dart';
import 'package:flutter/material.dart';

class LocalConstants {
  static const int limitProductNumberInCart = 15;
  static const double kHorizontalPadding = 16;
  static const double kBorderRadius = 10;
  static const String accessTokenNameInPref = "kAccessToken";
  static const String refreshTokenNameInPref = "kRefreshToken";
  static const String userModelNameInPref = "kUserModel";
  static const String isOnBoardingSeenNameInPref = "kIsOnBoardingSeen";
  static const String userAddressModelInPref = "kUserAddressModel";
  static const String lastRouteIdInPref = "kLastRouteIdInPref";
  static const String fingerprintEnabledPref = "kFingerprintEnabledPref";
  static const String userEmailNamePref = "user_email";
  static const String userPasswordNamePref = "user_password";
  static const String isMakingLoginAfterRegisterInPref = "kIsMakingLoginAfterRegister";

  static const internalPadding = EdgeInsets.symmetric(
    horizontal: kHorizontalPadding,
    vertical: 10,
  );

  static const List bottomNavigationBarData = [
    BottomNavigationBarModel(
      label: "Home",
      icon: Icon(Icons.home),
    ),
    BottomNavigationBarModel(
      label: "My Orders",
      icon: Icon(Icons.local_shipping),
    ),
    BottomNavigationBarModel(
      label: "Favorites",
      icon: Icon(Icons.favorite),
    ),
    BottomNavigationBarModel(
      label: "Cart",
      icon: Icon(Icons.shopping_cart),
    ),
    BottomNavigationBarModel(
      label: "Settings",
      icon: Icon(Icons.settings),
    ),
  ];
}
