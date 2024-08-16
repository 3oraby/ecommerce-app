import 'package:flutter/material.dart';
import 'validators.dart';

class RegistrationValidators {
  static FormFieldValidator<String>? getConfirmPasswordValidator(String? password) {
    return (value) {
      return Validators.confirmPasswordValidator(value, password);
    };
  }
}