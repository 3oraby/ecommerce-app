class RegisterRequestModel {
  String? userName;
  String? email;
  int? addressId;
  String userRole;
  String? password;
  String? confirmPassword;
  String? phoneNumber;

  RegisterRequestModel({
    this.userName,
    this.email,
    this.addressId,
    this.userRole = "user",
    this.password,
    this.confirmPassword,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_name': userName,
      'email': email,
      'address_id': addressId,
      'user_role': userRole,
      'password': password,
      'phone_number': phoneNumber,
    };
  }
}
