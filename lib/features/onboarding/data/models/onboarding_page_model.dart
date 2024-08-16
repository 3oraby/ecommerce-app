import 'package:flutter/material.dart';

class OnboardingPageModel {
  OnboardingPageModel({
    this.pageColor = Colors.white,
    this.mainTitleColor = Colors.black,
    this.descriptionColor = Colors.black,
    required this.mainTitle,
    required this.pageDescription,
    required this.pageImage,
  });
  Color? pageColor;
  Color? mainTitleColor;
  Color? descriptionColor;
  final String mainTitle;
  final String pageDescription;
  final String pageImage;
}
