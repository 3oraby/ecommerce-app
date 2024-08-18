import 'package:e_commerce_app/core/models/error_model.dart';

class DeleteFromCartResponseModel {
  final bool status;
  final ErrorModel? error;
  final String? message;

  DeleteFromCartResponseModel({
    required this.status,
    this.error,
    this.message,
  });
  factory DeleteFromCartResponseModel.fromJson(
      {required Map<String, dynamic> json}) {
    if (json["status"] == "success") {
      return DeleteFromCartResponseModel(
        status: true,
      );
    } else {
      return DeleteFromCartResponseModel(
        status: false,
        error: ErrorModel.fromJson(json['error']),
        message: json['message'],
      );
    }
  }
}
