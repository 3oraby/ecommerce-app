import 'package:e_commerce_app/models/error_model.dart';
import 'package:e_commerce_app/models/user_model.dart';

class VerifyEmailResponseModel {
  final bool status;
  final UserModel? user;
  final String? accessToken;
  final ErrorModel? error;
  final String? message;

  VerifyEmailResponseModel({
    required this.status,
    this.user,
    this.accessToken,
    this.error,
    this.message,
  });

  factory VerifyEmailResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['status'] == 'success') {
      return VerifyEmailResponseModel(
        status: true,
        user: UserModel.fromJson(json['data']['user']),
        accessToken: json['data']['accessToken'],
      );
    } else {
      return VerifyEmailResponseModel(
        status: false,
        message: json['message'],
        error: ErrorModel.fromJson(json['error']),
      );
    }
  }
}
