class Validators {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Enter a valid email address";
    } else {
      return null;
    }
  }

  static String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else {
      return null;
    }
  }

  static String? validateRegistrationPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    } else if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    } else {
      return null;
    }
  }

  static String? confirmPasswordValidator(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return "confirm password is required";
    } else if (value != password) {
      return "Passwords do not match";
    } else {
      return null;
    }
  }

  static String? requiredFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    } else {
      return null;
    }
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    } else if (!RegExp(r'^\+?[0-9]{11}$').hasMatch(value)) {
      return "Enter a valid phone number with exactly 11 digits";
    } else {
      return null;
    }
  }

  static String? imageUrlValidator(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (!Uri.parse(value).isAbsolute ||
        !Uri.parse(value).isScheme('http') &&
            !Uri.parse(value).isScheme('https')) {
      return "Enter a valid URL starting with http or https";
    } else {
      return null;
    }
  }
}
