import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';

class HomePageNavigationService {
  static void navigateToHome() {
    HomePage.currentIndexNotifier.value = 0;
  }

  static void navigateToMyOrders() {
    HomePage.currentIndexNotifier.value = 1;
  }

  static void navigateToFavorites() {
    HomePage.currentIndexNotifier.value = 2;
  }

  static void navigateToCart() {
    HomePage.currentIndexNotifier.value = 3;
  }

  static void navigateToSettings() {
    HomePage.currentIndexNotifier.value = 4;
  }
}
