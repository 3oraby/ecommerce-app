import 'package:e_commerce_app/features/auth/presentation/pages/login_page.dart';
import 'package:e_commerce_app/features/auth/presentation/pages/register_page.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/widgets/vertical_gap.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});
  static const id = "entryPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const VerticalGap(200),
            Center(
              child: LottieBuilder.asset(
                "assets/animations/signInPage.json",
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const VerticalGap(100),
            CustomTriggerButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, LoginPage.id);
              },
              description: "Login",
            ),
            CustomTriggerButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, RegisterPage.id);
              },
              description: "Create new account",
              backgroundColor: ThemeColors.secondaryColor,
              descriptionSize: 24,
            ),
          ],
        ),
      ),
    );
  }
}
