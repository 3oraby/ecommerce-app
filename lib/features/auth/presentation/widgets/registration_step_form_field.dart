import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/auth/constants/register_page_constants.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/register_page_stepper.dart';
import 'package:e_commerce_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationStepFormField extends StatelessWidget {
  final ScrollController stepperScrollController;
  final int completedSteps;
  final TextEditingController textEditingController;
  final VoidCallback scrollPageToBottom;
  final Map<RegistrationStep, String?> stepValues;

  const RegistrationStepFormField({
    super.key,
    required this.stepperScrollController,
    required this.completedSteps,
    required this.textEditingController,
    required this.scrollPageToBottom,
    required this.stepValues,
  });

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RegisterPageStepper(
          stepperScrollController: stepperScrollController,
          completedSteps: completedSteps,
        ),
        const VerticalGap(16),
        if (completedSteps < stepsList.length)
          CustomTextFormFieldWidget(
            controller: textEditingController,
            labelText: stepLabels[stepsList[completedSteps]]!,
            isObscure: stepsList[completedSteps] == RegistrationStep.password ||
                    stepsList[completedSteps] ==
                        RegistrationStep.confirmPassword
                ? true
                : false,
            onTap: scrollPageToBottom,
            validator: getValidatorForCurrentStep(
              completedSteps,
              authCubit.registerRequestModel.password,
            ),
            onChanged: (value) =>
                handleInputChange(value, completedSteps, authCubit),
            prefixIcon: chooseIconForEachStep(completedSteps: completedSteps),
            keyboardType:
                chooseKeyboardTypeForEachStep(completedSteps: completedSteps),
          ),
      ],
    );
  }

  Icon chooseIconForEachStep({required int completedSteps}) {
    switch (stepsList[completedSteps]) {
      case RegistrationStep.name:
        return const Icon(Icons.person);
      case RegistrationStep.email:
        return const Icon(Icons.email);
      case RegistrationStep.password:
        return const Icon(Icons.lock);
      case RegistrationStep.confirmPassword:
        return const Icon(Icons.lock_outline);
      case RegistrationStep.phone:
        return const Icon(Icons.phone);
      default:
        return const Icon(Icons.help_outline);
    }
  }

  TextInputType chooseKeyboardTypeForEachStep({required int completedSteps}) {
    switch (stepsList[completedSteps]) {
      case RegistrationStep.name:
        return TextInputType.text;
      case RegistrationStep.email:
        return TextInputType.emailAddress;
      case RegistrationStep.password:
      case RegistrationStep.confirmPassword:
        return TextInputType.text;
      case RegistrationStep.phone:
        return TextInputType.phone;
      default:
        return TextInputType.text;
    }
  }

  void handleInputChange(
      String value, int completedSteps, AuthCubit authCubit) {
    switch (stepsList[completedSteps]) {
      case RegistrationStep.name:
        authCubit.registerRequestModel.userName = value;
        break;
      case RegistrationStep.email:
        authCubit.registerRequestModel.email = value;
        break;
      case RegistrationStep.password:
        authCubit.registerRequestModel.password = value;
        break;
      case RegistrationStep.confirmPassword:
        authCubit.registerRequestModel.confirmPassword = value;
        break;
      case RegistrationStep.phone:
        authCubit.registerRequestModel.phoneNumber = value;
        break;
    }
  }
}
