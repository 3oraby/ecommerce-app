import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomTriggerButton extends StatelessWidget {
  const CustomTriggerButton({
    super.key,
    this.onPressed,
    this.description,
    this.icon,
    this.child,
    this.isEnabled = true,
    this.isDescriptionBold = true,
    this.backgroundColor = ThemeColors.primaryColor,
    this.descriptionColor = Colors.white,
    this.descriptionSize = 24,
    this.iconSize = 18,
    this.buttonHeight = 70,
    this.buttonWidth = double.infinity,
    this.borderWidth = 0,
    this.borderColor = Colors.black,
    this.borderRadius = 10,
    this.iconColor = Colors.white,
  });

  final bool isEnabled;
  final bool isDescriptionBold;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final String? description;
  final IconData? icon;
  final Color descriptionColor;
  final double descriptionSize;
  final double iconSize;
  final double buttonHeight;
  final double buttonWidth;
  final Widget? child;
  final double borderWidth;
  final Color borderColor;
  final double borderRadius;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            width: borderWidth,
            color: borderWidth == 0 ? Colors.white : borderColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: child ??
            Row(
              mainAxisAlignment: (icon == null)
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (description != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    description!,
                    style: TextStyle(
                      color: descriptionColor,
                      fontSize: descriptionSize,
                      fontWeight: isDescriptionBold
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
                if (icon != null)
                  Icon(
                    icon!,
                    color: iconColor,
                    size: iconSize,
                  ),
              ],
            ),
      ),
    );
  }
}
