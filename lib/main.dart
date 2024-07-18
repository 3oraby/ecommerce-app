import 'package:e_commerce_app/pages/entry_page.dart';
import 'package:e_commerce_app/pages/home_page.dart';
import 'package:e_commerce_app/pages/login_page.dart';
import 'package:e_commerce_app/pages/onboarding_page.dart';
import 'package:e_commerce_app/pages/register_page.dart';
import 'package:e_commerce_app/services/app_preferences_service.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  bool isFirstTime = await AppPreferencesService.isAppFirstTimeOpened();
  runApp(ECommerceApp(isFirstTime: isFirstTime));
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
      },
      initialRoute: isFirstTime ? OnboardingPage.id : EntryPage.id,
    );
  }
}
