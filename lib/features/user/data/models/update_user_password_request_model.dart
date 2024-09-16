class UpdateUserPasswordRequestModel {
  String? currentPassword;
  String? newPassword;

  UpdateUserPasswordRequestModel({this.currentPassword, this.newPassword});

  Map<String, dynamic> toJson() {
    return {"currentPassword": currentPassword, "newPassword": newPassword};
  }
}
