
enum RegistrationStep {
  name,
  email,
  password,
  confirmPassword,
  phone,
  image,
}

Map<RegistrationStep, String> stepLabels = {
  RegistrationStep.name: "Name",
  RegistrationStep.email: "Email",
  RegistrationStep.password: "Password",
  RegistrationStep.confirmPassword: "Confirm Password",
  RegistrationStep.phone: "Phone",
  RegistrationStep.image: "Image",
};

List<RegistrationStep> get stepsList => RegistrationStep.values;


