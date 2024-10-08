import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

Future<dynamic> customShowModalBottomSheet({
  required BuildContext context,
  required String imageName,
  required String sheetDescription,
  required void Function() onPressed,
  String buttonDescription = "go to HomePage",
  double sheetHeight = 400,
  double horizontalPadding = 16,
}) {
  return showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) =>
            false,
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: sheetHeight,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    LottieBuilder.asset(
                      imageName,
                      width: 300,
                      height: 150,
                    ),
                    Text(
                      sheetDescription,
                      style: GoogleFonts.aBeeZee(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomTriggerButton(
                      onPressed: onPressed,
                      description: buttonDescription,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
