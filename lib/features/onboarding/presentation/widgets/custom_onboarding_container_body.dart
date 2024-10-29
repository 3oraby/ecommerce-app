
import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/onboarding/constants/onboarding_page_data.dart';
import 'package:e_commerce_app/features/onboarding/data/models/onboarding_page_model.dart';
import 'package:e_commerce_app/features/onboarding/presentation/widgets/onboarding_nav_row.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomOnboardingContainerBody extends StatelessWidget {
  const CustomOnboardingContainerBody({
    super.key,
    required this.item,
    required this.isLastPage,
    required this.pageController,
  });

  final OnboardingPageModel item;
  final bool isLastPage;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    List<OnboardingPageModel> onboardingPagesList =
        OnboardingPageData.onboardingPagesList;
    return Container(
      color: item.pageColor,
      child: Column(
        children: [
          Lottie.asset(
            item.pageImage,
            height: 300,
            width: 300,
            fit: BoxFit.cover,
          ),
          Text(
            item.mainTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              color: item.mainTitleColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const VerticalGap(8),
          Text(
            item.pageDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: item.descriptionColor,
            ),
            maxLines: 4,
          ),
          const Spacer(),
          isLastPage
              ? CustomTriggerButton(
                  onPressed: () {
                    SharedPreferencesSingleton.setBool(
                        LocalConstants.isOnBoardingSeenNameInPref, true);
                    Navigator.pushReplacementNamed(context, HomePage.id);
                  },
                  description: "Get Started",
                  backgroundColor: ThemeColors.secondaryColor,
                  descriptionColor: Colors.white,
                  buttonHeight: 50,
                )
              : OnboardingNavRow(
                  pageController: pageController,
                  onboardingPagesList: onboardingPagesList,
                ),
          const VerticalGap(16),      
        ],
      ),
    );
  }
}
