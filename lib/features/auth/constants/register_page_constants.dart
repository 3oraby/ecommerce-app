import 'package:e_commerce_app/validation/registration_validators.dart';
import 'package:e_commerce_app/validation/validators.dart';
import 'package:flutter/material.dart';

enum RegistrationStep {
  name,
  email,
  password,
  confirmPassword,
  phone,
}

Map<RegistrationStep, String> stepLabels = {
  RegistrationStep.name: "Name",
  RegistrationStep.email: "Email",
  RegistrationStep.password: "Password",
  RegistrationStep.confirmPassword: "Confirm Password",
  RegistrationStep.phone: "Phone",
};

List<RegistrationStep> get stepsList => RegistrationStep.values;

FormFieldValidator<String>? getValidatorForCurrentStep(
    int completedSteps, String? password) {
  switch (stepsList[completedSteps]) {
    case RegistrationStep.name:
      return Validators.requiredFieldValidator;
    case RegistrationStep.email:
      return Validators.emailValidator;
    case RegistrationStep.password:
      return Validators.validateRegistrationPassword;
    case RegistrationStep.confirmPassword:
      return RegistrationValidators.getConfirmPasswordValidator(password);
    case RegistrationStep.phone:
      return Validators.phoneValidator;
    default:
      return null;
  }
}
