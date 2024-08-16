
import 'package:e_commerce_app/features/onboarding/data/models/onboarding_page_model.dart';

class OnboardingPageData {
  static List<OnboardingPageModel> onboardingPagesList = [
    OnboardingPageModel(
      mainTitle: "Purchase Online",
      pageDescription: "Browse, select, and buy your desired products conveniently from the comfort of your home.",
      pageImage: "assets/animations/buyOnline.json",
    ),
    OnboardingPageModel(
      mainTitle: "Track Order",
      pageDescription: "Easily track the status and delivery of your orders in real-time, ensuring peace of mind with every purchase.",
      pageImage: "assets/animations/trackOrder.json",
    ),
    OnboardingPageModel(
      mainTitle: "Get your order",
      pageDescription: "Receive your orders swiftly and securely, ensuring your products arrive at your doorstep with ease and satisfaction.",
      pageImage: "assets/animations/getYourOrder.json",
    ),
  ];
}
