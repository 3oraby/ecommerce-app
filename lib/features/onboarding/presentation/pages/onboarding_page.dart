import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/features/onboarding/constants/onboarding_page_data.dart';
import 'package:e_commerce_app/features/onboarding/data/models/onboarding_page_model.dart';
import 'package:e_commerce_app/features/onboarding/presentation/widgets/custom_onboarding_container_body.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});
  static const id = "onboardingPage";

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController pageController = PageController();
  bool isLastPage = false;
  List<OnboardingPageModel> onboardingPagesList =
      OnboardingPageData.onboardingPagesList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ThemeColors.primaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 24, 0),
            child: CustomTriggerButton(
              onPressed: () {
                if (isLastPage == true) {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                } else {
                  pageController.jumpToPage(onboardingPagesList.length - 1);
                }
              },
              description: isLastPage ? "previous" : "skip",
              backgroundColor: Colors.orange,
              descriptionColor: Colors.white,
              buttonHeight: 60,
              buttonWidth: 120,
              descriptionSize: 20,
            ),
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(500),
            bottomLeft: Radius.circular(150),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(180),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                LocalConstants.kHorizontalPadding, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Lottie.asset(
                  "assets/animations/signInPage.json",
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
                const Text(
                  "eCommerce Shop",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  indent: 0,
                  endIndent: 180,
                ),
                const Text(
                  "Professional App for your ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                const Text(
                  "eCommerce business",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                const VerticalGap(30),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                isLastPage = (value == onboardingPagesList.length - 1);
              });
            },
            children: [
              for (OnboardingPageModel item in onboardingPagesList)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: LocalConstants.kHorizontalPadding,
                    vertical: 8,
                  ),
                  child: CustomOnboardingContainerBody(
                    item: item,
                    isLastPage: isLastPage,
                    pageController: pageController,
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
