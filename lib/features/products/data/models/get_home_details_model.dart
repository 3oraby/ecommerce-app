import 'package:e_commerce_app/core/models/error_model.dart';
import 'package:e_commerce_app/core/models/home_page_data_model.dart';

class GetHomeDetailsResponseModel {
  final bool status;
  final List<HomePageDataModel>? data;
  final ErrorModel? error;
  final String? message;

  GetHomeDetailsResponseModel({
    required this.status,
    this.data,
    this.error,
    this.message,
  });

  factory GetHomeDetailsResponseModel.fromJson(
      {required Map<String, dynamic> json}) {
    if (json["status"] == "success") {
      List dataList = json["data"];
      return GetHomeDetailsResponseModel(
        status: true,
        data: dataList
            .map(
              (jsonData) => HomePageDataModel.fromJson(json: jsonData),
            )
            .toList(),
      );
    } else {
      return GetHomeDetailsResponseModel(
        status: false,
        error: ErrorModel.fromJson(json['error']),
        message: json['message'],
      );
    }
  }
}
