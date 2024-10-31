
import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:flutter/material.dart';

class CustomPaddingDecorationButton extends StatelessWidget {
  const CustomPaddingDecorationButton({
    super.key,
    this.verticalPadding = 8,
    this.horizontalPadding = LocalConstants.kHorizontalPadding,
    this.borderRadius = LocalConstants.kBorderRadius,
    this.borderWidth = 1,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.grey,
    this.onTap,
    required this.child,
  });
  final double verticalPadding;
  final double horizontalPadding;
  final double borderRadius;
  final double borderWidth;
  final Color backgroundColor;
  final Color borderColor;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        child: child,
      ),
    );
  }
}
