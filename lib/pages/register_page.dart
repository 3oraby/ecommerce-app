import 'dart:developer';

import 'package:e_commerce_app/constants/register_page_constants.dart';
import 'package:e_commerce_app/pages/login_page.dart';
import 'package:e_commerce_app/services/user_services/register_service.dart';
import 'package:e_commerce_app/widgets/custom_text_form_field.dart';
import 'package:e_commerce_app/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/widgets/vertical_gap.dart';
import 'package:e_commerce_app/widgets/register_page_stepper.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static const id = "registerPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final PageController pageController = PageController();
  final ScrollController stepperScrollController = ScrollController();
  final ScrollController listViewScrollController = ScrollController();

  int completedSteps = 0;

  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  String? phone;
  String? imageUrl;

  void scrollPageToBottom() {
    listViewScrollController.animateTo(
      listViewScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void scrollToActiveTile(int currentPage) {
    double offset = currentPage * 100;
    stepperScrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void onPageChanged(int currentPage) {
    scrollToActiveTile(currentPage);
  }

  void onContinuePressed() async {
    if (completedSteps < stepsList.length) {
      setState(() {
        completedSteps++;
      });
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      // Handle the "Create account" action
      // Navigate to home page or perform account creation
      bool success = await RegisterService().createAccount(
        name: name!,
        email: email!,
        password: password!,
        phone: phone!,
        imageUrl: imageUrl!,
      );

      if (success) {
        // Navigate to the home page or display a success message
        log('Registration successful');
      } else {
        // Display an error message
        log('Registration failed');
      }
    }
  }

  void onBackPressed() {
    if (completedSteps > 0) {
      setState(() {
        completedSteps--;
        if (stepsList[completedSteps] == RegistrationStep.confirmPassword) {
          // skip confirm password to change the password first
          completedSteps--;
        }
      });
      pageController.animateToPage(
        completedSteps,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ListView(
          controller: listViewScrollController,
          reverse: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTriggerButton(
                  backgroundColor: Colors.orange,
                  icon: Icons.arrow_back,
                  onPressed: onBackPressed,
                  buttonWidth: 70,
                  buttonHeight: 40,
                ),
              ],
            ),
            Lottie.asset(
              "assets/animations/trackOrder.json",
              height: 200,
              fit: BoxFit.cover,
            ),
            const VerticalGap(180),
            const Text(
              "Create account",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 220,
              child: PageView(
                controller: pageController,
                onPageChanged: onPageChanged,
                physics:
                    const NeverScrollableScrollPhysics(), // to prevent user scrolling
                children: stepsList.map((step) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RegisterPageStepper(
                        stepperScrollController: stepperScrollController,
                        completedSteps: completedSteps,
                      ),
                      const VerticalGap(32),
                      if (completedSteps < stepsList.length)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CustomTextFormFieldWidget(
                            labelText: stepLabels[stepsList[completedSteps]]!,
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            onTap: scrollPageToBottom,
                            onChanged: (value) {
                              switch (stepsList[completedSteps]) {
                                case RegistrationStep.name:
                                  name = value;
                                  break;
                                case RegistrationStep.email:
                                  email = value;
                                  break;
                                case RegistrationStep.password:
                                  password = value;
                                  break;
                                case RegistrationStep.confirmPassword:
                                  confirmPassword = value;
                                  break;
                                case RegistrationStep.phone:
                                  phone = value;
                                  break;
                                case RegistrationStep.image:
                                  imageUrl = value;
                                  break;
                              }
                            },
                          ),
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
            Center(
              child: CustomTriggerButton(
                backgroundColor: Colors.orange,
                description: completedSteps == stepsList.length
                    ? "Create account"
                    : "Continue",
                onPressed: onContinuePressed,
                descriptionColor: Colors.white,
                buttonWidth: 300,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "already have an account ?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, LoginPage.id);
                  },
                  child: const Text(
                    "Login",
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
            const VerticalGap(70),
          ].reversed.toList(),
        ),
      ),
    );
  }
}
