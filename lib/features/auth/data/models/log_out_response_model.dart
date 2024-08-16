import 'package:e_commerce_app/core/models/error_model.dart';

class LogOutResponseModel {
  final bool status;
  final String message;
  final ErrorModel? error;

  LogOutResponseModel({
    required this.status,
    required this.message,
    this.error,
  });

  factory LogOutResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['status'] == 'success') {
      return LogOutResponseModel(
        status: true,
        message: json["message"],
      );
    } else {
      return LogOutResponseModel(
        status: false,
        message: json['message'],
        error: ErrorModel.fromJson(json['error']),
      );
    }
  }
}
