import 'package:e_commerce_app/core/models/error_model.dart';

class RegisterResponseModel {
  final bool status;
  final String? verifyAccLink;
  final ErrorModel? error;
  final String? message;

  RegisterResponseModel({
    required this.status,
    this.verifyAccLink,
    this.error,
    this.message,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['status'] == 'success') {
      return RegisterResponseModel(
        status: true,
        verifyAccLink: json["link"],
      );
    } else {
      return RegisterResponseModel(
        status: false,
        message: json['message'],
        error: ErrorModel.fromJson(json['error']),
      );
    }
  }
}
