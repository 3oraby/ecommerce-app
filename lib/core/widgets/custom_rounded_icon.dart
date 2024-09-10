

import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomRoundedIcon extends StatelessWidget {
  const CustomRoundedIcon({
    super.key,
    required this.child,
    this.backgroundColor = ThemeColors.successfullyDoneColor,
    this.internalPadding = 6,
  });

  final Widget child;
  final Color backgroundColor;
  final double internalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(internalPadding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(360),
      ),
      child: child,
    );
  }
}
