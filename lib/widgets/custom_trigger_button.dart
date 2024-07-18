import 'package:e_commerce_app/services/app_preferences_service.dart';
import 'package:flutter/material.dart';

class CustomTriggerButton extends StatefulWidget {
  const CustomTriggerButton({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    this.description,
    this.icon,
    this.descriptionColor = Colors.white,
    this.descriptionSize = 30,
    this.isUseForOnBoarding = false,
    this.buttonHeight = 70,
    this.buttonWidth = double.infinity,
    this.borderWidth = 2,
    this.borderColor = Colors.black,
    this.borderRadius = 40,
  });

  final VoidCallback onPressed;
  final Color backgroundColor;
  final String? description;
  final IconData? icon;
  final Color? descriptionColor;
  final double? descriptionSize;
  final double? buttonHeight;
  final double? buttonWidth;
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
      AppPreferencesService.markOnboardingComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                size: widget.descriptionSize,
              ),
          ],
        ),
      ),
    );
  }
}
