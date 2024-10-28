import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/navigation/home_page_navigation_service.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_rounded_icon.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

void showCartSuccessModal({
  required BuildContext context,
  required ProductModel productModel,
  required String cartPrice,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const VerticalGap(16),
              Row(
                children: [
                  const CustomRoundedIcon(
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                  ),
                  const HorizontalGap(24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            productModel.name,
                            style: TextStyles.aDLaMDisplayBlackBold20,
                          ),
                        ),
                        const Text(
                          "Added to cart",
                          style: TextStyle(
                            color: ThemeColors.successfullyDoneColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const VerticalGap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Cart Total",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "EGP $cartPrice",
                    style: TextStyles.aDLaMDisplayBlackBold20,
                  ),
                ],
              ),
              const VerticalGap(16),
              CustomTriggerButton(
                buttonHeight: 50,
                backgroundColor: Colors.white,
                description: "CONTINUE SHOPPING",
                isDescriptionBold: true,
                descriptionSize: 20,
                descriptionColor: ThemeColors.primaryColor,
                onPressed: () {
                  Navigator.pop(context);
                },
                borderColor: ThemeColors.primaryColor,
                borderWidth: 2,
              ),
              const VerticalGap(16),
              CustomTriggerButton(
                buttonHeight: 50,
                description: "VIEW CART",
                isDescriptionBold: true,
                descriptionSize: 20,
                onPressed: () {
                  HomePageNavigationService.navigateToCart();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    HomePage.id,
                    (Route<dynamic> route) => false,
                  );
                },
              ),
              const VerticalGap(16),
            ],
          ),
        ),
      );
    },
  );
}
