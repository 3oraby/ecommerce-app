
import 'package:e_commerce_app/core/models/error_model.dart';
import 'package:e_commerce_app/core/models/user_model.dart';

class GetUserResponseModel {
  final bool status;
  final String? message;
  final UserModel? user;
  final ErrorModel? error;

  GetUserResponseModel({
    required this.status,
    this.message,
    this.user,
    this.error,
  });

  factory GetUserResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['status'] == 'success') {
      return GetUserResponseModel(
        status: true,
        user: UserModel.fromJson(json['data']),
      );
    } else {
      return GetUserResponseModel(
        status: false,
        message: json['message'],
        error: ErrorModel.fromJson(json['error']),
      );
    }
  }
}