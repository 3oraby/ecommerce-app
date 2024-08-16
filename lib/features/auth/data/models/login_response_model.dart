
import 'package:e_commerce_app/models/error_model.dart';
import 'package:e_commerce_app/models/user_model.dart';

class LoginResponseModel {
  final bool status;
  final String? message;
  final UserModel? user;
  final String? accessToken;
  final ErrorModel? error;

  LoginResponseModel({
    required this.status,
    this.message,
    this.user,
    this.accessToken,
    this.error,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['status'] == 'success') {
      return LoginResponseModel(
        status: true,
        user: UserModel.fromJson(json['data']['user']),
        accessToken: json['data']['accessToken'],
      );
    } else {
      return LoginResponseModel(
        status: false,
        message: json['message'],
        error: ErrorModel.fromJson(json['error']),
      );
    }
  }
}