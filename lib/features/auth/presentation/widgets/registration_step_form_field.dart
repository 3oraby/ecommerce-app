import 'package:e_commerce_app/features/auth/constants/register_page_constants.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/register_page_stepper.dart';
import 'package:e_commerce_app/core/widgets/custom_text_form_field.dart';
import 'package:e_commerce_app/features/user/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationStepFormField extends StatelessWidget {
  final ScrollController stepperScrollController;
  final int completedSteps;
  final TextEditingController textEditingController;
  final VoidCallback scrollPageToBottom;
  final Map<RegistrationStep, String?> stepValues;
  // final RegisterRequestModel registerRequestModel;

  const RegistrationStepFormField({
    super.key,
    required this.stepperScrollController,
    required this.completedSteps,
    required this.textEditingController,
    required this.scrollPageToBottom,
    required this.stepValues,
    // required this.registerRequestModel,
  });

  @override
  Widget build(BuildContext context) {
    final UserCubit userCubit = BlocProvider.of<UserCubit>(context);

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
            isObscure: stepsList[completedSteps] == RegistrationStep.password ||
                    stepsList[completedSteps] ==
                        RegistrationStep.confirmPassword
                ? true
                : false,
            onTap: scrollPageToBottom,
            validator: getValidatorForCurrentStep(
              completedSteps,
              userCubit.registerRequestModel.password,
            ),
            onChanged: (value) {
              switch (stepsList[completedSteps]) {
                case RegistrationStep.name:
                  userCubit.registerRequestModel.userName = value;
                  break;
                case RegistrationStep.email:
                  userCubit.registerRequestModel.email = value;
                  break;
                case RegistrationStep.password:
                  userCubit.registerRequestModel.password = value;
                  break;
                case RegistrationStep.confirmPassword:
                  userCubit.registerRequestModel.confirmPassword = value;
                  break;
                case RegistrationStep.phone:
                  userCubit.registerRequestModel.phoneNumber = value;
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
