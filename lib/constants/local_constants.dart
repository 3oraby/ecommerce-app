import 'package:e_commerce_app/models/bottom_navigation_bar_model.dart';
import 'package:flutter/material.dart';

//! move it to the constants which in the home feature
class LocalConstants {
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
