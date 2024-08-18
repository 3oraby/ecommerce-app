import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomTriggerButton extends StatefulWidget {
  const CustomTriggerButton({
    super.key,
    this.onPressed,
    this.description,
    this.icon,
    this.child,
    this.isEnabled = true,
    this.backgroundColor = ThemeColors.primaryColor,
    this.descriptionColor = Colors.white,
    this.descriptionSize = 30,
    this.iconSize = 18,
    this.isUseForOnBoarding = false,
    this.buttonHeight = 70,
    this.buttonWidth = double.infinity,
    this.borderWidth = 2,
    this.borderColor = Colors.black,
    this.borderRadius = 40,
  });

  final bool isEnabled;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final String? description;
  final IconData? icon;
  final Color? descriptionColor;
  final double? descriptionSize;
  final double? iconSize;
  final double? buttonHeight;
  final double? buttonWidth;
  final Widget? child;
  final double borderWidth;
  final Color borderColor;
  final double borderRadius;
  final bool isUseForOnBoarding;
  @override
  State<CustomTriggerButton> createState() => _CustomTriggerButtonState();
}

class _CustomTriggerButtonState extends State<CustomTriggerButton> {
  @override
  void initState() {
    super.initState();
    if (widget.isUseForOnBoarding) {
      SharedPreferencesSingleton.setBool("isFirstTime", true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.isEnabled ? widget.onPressed : null,
      child: Container(
        height: widget.buttonHeight,
        width: widget.buttonWidth,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          border: Border.all(
            width: widget.borderWidth,
            color: widget.borderColor,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: widget.child ??
            Row(
              mainAxisAlignment: (widget.icon == null)
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.description != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    widget.description!,
                    style: TextStyle(
                      color: widget.descriptionColor,
                      fontSize: widget.descriptionSize,
                    ),
                  ),
                ],
                if (widget.icon != null)
                  Icon(
                    widget.icon!,
                    color: widget.descriptionColor,
                    size: widget.iconSize,
                  ),
              ],
            ),
      ),
    );
  }
}
