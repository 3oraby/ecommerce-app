import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustomTimeLineTile extends StatelessWidget {
  const CustomTimeLineTile({
    super.key,
    required this.completedSteps,
    required this.currentStep,
    required this.label,
    this.isFirstStep = false,
    this.isLastStep = false,
    this.completedStepColor = ThemeColors.primaryColor,
    this.incompleteStepColor = Colors.grey,
    this.completedStepIcon = const Icon(
      Icons.done_all,
      color: ThemeColors.primaryColor,
      size: 32,
    ),
    this.labelTextStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  });

  final int completedSteps;
  final int currentStep;
  final String label;
  final bool isFirstStep;
  final bool isLastStep;
  final Color completedStepColor;
  final Color incompleteStepColor;
  final Icon completedStepIcon;
  final TextStyle labelTextStyle;

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirstStep,
      isLast: isLastStep,
      alignment: TimelineAlign.center,
      axis: TimelineAxis.horizontal,
      indicatorStyle: IndicatorStyle(
        color: completedSteps > currentStep
            ? completedStepColor
            : incompleteStepColor,
        height: 30,
      ),
      hasIndicator: true,
      startChild: completedSteps > currentStep
          ? null
          : currentStep % 2 != 0
              ? Text(
                  label,
                  style: labelTextStyle,
                )
              : null,
      endChild: completedSteps > currentStep
          ? Column(
              children: [
                completedStepIcon,
              ],
            )
          : currentStep % 2 == 0
              ? Text(
                  label,
                  style: labelTextStyle,
                )
              : null,
      afterLineStyle: LineStyle(
        color: completedSteps > currentStep
            ? completedStepColor
            : incompleteStepColor,
      ),
      beforeLineStyle: LineStyle(
        color: completedSteps > currentStep - 1
            ? completedStepColor
            : incompleteStepColor,
      ),
    );
  }
}
