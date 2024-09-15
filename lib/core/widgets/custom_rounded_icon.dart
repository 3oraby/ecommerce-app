

import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomRoundedIcon extends StatelessWidget {
  const CustomRoundedIcon({
    super.key,
    required this.child,
    this.backgroundColor = ThemeColors.successfullyDoneColor,
    this.internalHorizontalPadding = 8,
    this.internalVerticalPadding = 8,
  });

  final Widget child;
  final Color backgroundColor;
  final double internalHorizontalPadding;
  final double internalVerticalPadding;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: internalHorizontalPadding,
        vertical: internalVerticalPadding,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(360),
      ),
      child: child,
    );
  }
}
