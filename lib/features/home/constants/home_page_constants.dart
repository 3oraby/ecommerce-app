import 'package:e_commerce_app/core/utils/app_assets/images/app_images.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:flutter/material.dart';

class HomePageConstants {
  final UserModel ?userModel;
  HomePageConstants({this.userModel});
  
  static const List homePageTabs = ["Home", "Category"];
  static const Color selectedColor = Colors.black;
  static const Color unSelectedColor = Colors.grey;

  static const List homeTapBodySalePhotos = [
    AppImages.imagesSalesPhoto4,
    AppImages.imagesSalesPhoto1,
    AppImages.imagesSalesPhoto2,
    AppImages.imagesSalesPhoto3,
  ];
}
