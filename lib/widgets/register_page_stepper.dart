
import 'package:e_commerce_app/constants/register_page_constants.dart';
import 'package:e_commerce_app/widgets/custom_time_line_tile.dart';
import 'package:flutter/material.dart';

class RegisterPageStepper extends StatelessWidget {
  const RegisterPageStepper({
    super.key,
    required this.stepperScrollController,
    required this.completedSteps,
  });

  final ScrollController stepperScrollController;
  final int completedSteps;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        controller: stepperScrollController,
        scrollDirection: Axis.horizontal,
        itemCount: stepsList.length,
        itemBuilder: (context, index) {
          return CustomTimeLineTile(
            completedSteps: completedSteps,
            currentStep: index,
            label: stepLabels[stepsList[index]]!,
            isFirstStep: index == 0,
            isLastStep: index == stepsList.length - 1,
            incompleteStepColor: Colors.grey,
          );
        },
      ),
    );
  }
}
