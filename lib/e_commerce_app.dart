import 'package:e_commerce_app/constants/routes_map.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/onboarding/presentation/pages/onboarding_page.dart';
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
      routes: appRoutesMap,
      initialRoute: isFirstTime ? OnboardingPage.id : HomePage.id,
    );
  }
}
