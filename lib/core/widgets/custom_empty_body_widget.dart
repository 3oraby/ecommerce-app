import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/utils/app_assets/images/app_images.dart';
import 'package:e_commerce_app/core/utils/navigation/home_page_navigation_service.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomEmptyBodyWidget extends StatelessWidget {
  const CustomEmptyBodyWidget({
    super.key,
    required this.mainLabel,
    required this.subLabel,
    required this.buttonDescription,
    this.imageName = AppImages.imagesNoData,
    this.onButtonPressed,
    this.bodyColor = Colors.white,
  });

  final String imageName;
  final String mainLabel;
  final String subLabel;
  final String buttonDescription;
  final VoidCallback? onButtonPressed;
  final Color bodyColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bodyColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imageName,
                height: MediaQuery.of(context).size.height *
                    0.25, 
                width: MediaQuery.of(context).size.width *
                    0.5, 
              ),
              const VerticalGap(20),
              Text(
                mainLabel,
                style: GoogleFonts.roboto(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const VerticalGap(10),
              Text(
                subLabel,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: Colors.black38,
                ),
              ),
              const VerticalGap(30),
              ElevatedButton(
                onPressed: onButtonPressed ??
                    () {
                      HomePageNavigationService.navigateToHome();
                    },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColors.primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(LocalConstants.kBorderRadius),
                  ),
                ),
                child: Text(
                  buttonDescription,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
