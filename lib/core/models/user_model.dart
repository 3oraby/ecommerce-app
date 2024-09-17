class UserModel {
  int? id;
  int? addressId;
  String? userName;
  String? userRole;
  String? email;
  String? phoneNumber;

  UserModel({
    this.id,
    this.addressId,
    this.userName,
    this.userRole,
    this.email,
    this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      addressId: json["address_id"],
      userName: json["user_name"],
      userRole: json["user_role"],
      email: json['email'],
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "address_id": addressId,
      "user_name": userName,
      "user_role": userRole,
      "email": email,
      "phone_number": phoneNumber,
    };
  }
}
