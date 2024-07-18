import 'dart:developer';

import 'package:e_commerce_app/pages/home_page.dart';
import 'package:e_commerce_app/pages/register_page.dart';
import 'package:e_commerce_app/services/user_services/login_service.dart';
import 'package:e_commerce_app/widgets/custom_text_form_field.dart';
import 'package:e_commerce_app/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/widgets/vertical_gap.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const id = "loginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int completedSteps = 1;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: ListView(
          reverse: true,
          children: [
            Lottie.asset("assets/animations/trackOrder.json"),
            const Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const VerticalGap(30),
            CustomTextFormFieldWidget(
              labelText: "Email",
              onChanged: (email) {
                this.email = email;
              },
            ),
            const VerticalGap(30),
            CustomTextFormFieldWidget(
              labelText: "Password",
              onChanged: (password) {
                this.password = password;
              },
            ),
            const VerticalGap(30),
            CustomTriggerButton(
              onPressed: () async {
                bool response = await LoginService().verifyLogin(
                  email: email!,
                  password: password!,
                );
                if (response) {
                  log(email!);
                  log(password!);
                  log("message");
                  Navigator.pushReplacementNamed(context, HomePage.id);
                } else {
                  log("false");
                }
              },
              backgroundColor: Colors.orange,
              description: "Log In",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "don't have an account ?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, RegisterPage.id);
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
            const VerticalGap(100)
          ].reversed.toList(),
        ),
      ),
    );
  }
}
