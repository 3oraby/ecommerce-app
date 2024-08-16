

import 'package:e_commerce_app/features/onboarding/data/models/onboarding_page_model.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingNavRow extends StatelessWidget {
  const OnboardingNavRow({
    super.key,
    required this.pageController,
    required this.onboardingPagesList,
  });

  final PageController pageController;
  final List<OnboardingPageModel> onboardingPagesList;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // previous button
        CustomTriggerButton(
          onPressed: () {
            pageController.previousPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
          description: "previous",
          descriptionColor: Colors.white,
          buttonHeight: 50,
          buttonWidth: 130,
          descriptionSize: 20,
        ),
        // smooth page indicator
        SmoothPageIndicator(
          controller: pageController,
          count: onboardingPagesList.length,
          effect: const WormEffect(
            spacing: 16,
            dotColor: Colors.grey,
          ),
        ),
        // next button
        CustomTriggerButton(
          onPressed: () {
            pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
          description: "next",
          descriptionColor: Colors.white,
          buttonHeight: 50,
          buttonWidth: 130,
          descriptionSize: 20,
        ),
      ],
    );
  }
}
