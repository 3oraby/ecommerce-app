import 'package:e_commerce_app/constants/routes_map.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter/material.dart';

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({
    super.key,
    required this.isOnBoardingSeen,
  });

  final bool isOnBoardingSeen;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: appRoutesMap,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: ThemeColors.primaryColor,
        ),
      ),
      initialRoute: isOnBoardingSeen ? HomePage.id : OnboardingPage.id,
      // initialRoute: VerifyEmailPage.id,
    );
  }
}
