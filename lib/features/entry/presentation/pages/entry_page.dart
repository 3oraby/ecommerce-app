import 'package:e_commerce_app/features/address/presentation/pages/add_address_page.dart';
import 'package:e_commerce_app/features/auth/presentation/pages/login_page.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
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
            const Spacer(flex: 10),
            Center(
              child: LottieBuilder.asset(
                "assets/animations/signInPage.json",
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const Spacer(flex: 6),
            CustomTriggerButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, LoginPage.id);
              },
              description: "Login",
            ),
            const Spacer(flex: 1),
            CustomTriggerButton(
              onPressed: () {
                Navigator.pushNamed(context, AddAddressPage.id);
              },
              description: "Create new account",
              backgroundColor: ThemeColors.secondaryColor,
              descriptionSize: 24,
            ),
            const Spacer(flex: 6),
          ],
        ),
      ),
    );
  }
}
