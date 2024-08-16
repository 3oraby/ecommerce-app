import 'package:e_commerce_app/features/auth/constants/register_page_constants.dart';
import 'package:e_commerce_app/features/auth/data/models/register_request_model.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/register_page_stepper.dart';
import 'package:e_commerce_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class RegistrationStepFormField extends StatelessWidget {
  final ScrollController stepperScrollController;
  final int completedSteps;
  final TextEditingController textEditingController;
  final VoidCallback scrollPageToBottom;
  final Map<RegistrationStep, String?> stepValues;
  final RegisterRequestModel registerRequestModel;

  const RegistrationStepFormField({
    super.key,
    required this.stepperScrollController,
    required this.completedSteps,
    required this.textEditingController,
    required this.scrollPageToBottom,
    required this.stepValues,
    required this.registerRequestModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RegisterPageStepper(
          stepperScrollController: stepperScrollController,
          completedSteps: completedSteps,
        ),
        //? optional image
        // const VerticalGap(32),
        // if (completedSteps < stepsList.length &&
        //     stepsList[completedSteps] == RegistrationStep.image)
        //   const Column(
        //     children: [
        //       Text(
        //         "Optional",
        //         style: TextStyle(
        //           fontSize: 20,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //       VerticalGap(8),
        //     ],
        //   ),
        if (completedSteps < stepsList.length)
          CustomTextFormFieldWidget(
            controller: textEditingController,
            labelText: stepLabels[stepsList[completedSteps]]!,
            labelStyle: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            isObscure: stepsList[completedSteps] == RegistrationStep.password ||
                    stepsList[completedSteps] ==
                        RegistrationStep.confirmPassword
                ? true
                : false,
            onTap: scrollPageToBottom,
            validator: getValidatorForCurrentStep(
              completedSteps,
              registerRequestModel.password,
            ),
            onChanged: (value) {
              switch (stepsList[completedSteps]) {
                case RegistrationStep.name:
                  registerRequestModel.userName = value;
                  break;
                case RegistrationStep.email:
                  registerRequestModel.email = value;
                  break;
                case RegistrationStep.password:
                  registerRequestModel.password = value;
                  break;
                case RegistrationStep.confirmPassword:
                  registerRequestModel.confirmPassword = value;
                  break;
                case RegistrationStep.phone:
                  registerRequestModel.phoneNumber = value;
                  break;
                // case RegistrationStep.addressId:
                //   registerRequestModel.addressId = value;
                //   break;
              }
            },
          ),
      ],
    );
  }
}
