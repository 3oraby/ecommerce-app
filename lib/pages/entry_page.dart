import 'package:e_commerce_app/pages/login_page.dart';
import 'package:e_commerce_app/pages/register_page.dart';
import 'package:e_commerce_app/widgets/custom_trigger_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});
  static const id = "entryPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          Center(
            child: LottieBuilder.asset(
              "assets/animations/signInPage.json",
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          CustomTriggerButton(
            onPressed: (){
              Navigator.pushNamed(context, LoginPage.id);
            },
            description: "Login",
            backgroundColor: Colors.blue[800]!,
          ),
          CustomTriggerButton(
            onPressed: (){
              Navigator.pushNamed(context, RegisterPage.id);
            },
            description: "Create new account",
            backgroundColor: Colors.blue,
            descriptionSize: 24,
          ),
        ],
      ),
    );
  }
}
