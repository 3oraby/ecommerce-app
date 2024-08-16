import 'package:e_commerce_app/core/utils/app_assets/images/app_images.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:flutter/material.dart';

class HomePageConstants {
  final UserModel ?userModel;
  HomePageConstants({this.userModel});
  
  // tabs
  static const List homePageTabs = ["Home", "Category"];
  static const Color selectedColor = Colors.black;
  static const Color unSelectedColor = Colors.grey;

  // home tab body
  static const List homeTapBodySalePhotos = [
    AppImages.salesPhoto1,
    AppImages.salesPhoto2,
    AppImages.salesPhoto3,
  ];

  // // home page app bars
  // static const List homePageAppBars = [
  //   HomeAppBar(),
  //   MyOrdersAppBar(),
  //   FavoritesAppBar(),
  //   CartAppBar(),
  //   SettingsAppBar(),
  // ];

  // // home page bodies
  // static const List homePageBodies = [
  //   HomeBody(),
  //   MyOrdersBody(),
  //   FavoritesBody(),
  //   CartBody(),
  //   SettingsBody(),
  // ];

}
