
import 'package:e_commerce_app/core/models/error_model.dart';
import 'package:e_commerce_app/features/address/data/models/address_model.dart';

class GetAllAddressesResponseModel {
  final bool status;
  final List<AddressModel>? addresses;
  final ErrorModel? error;
  final String? message;

  GetAllAddressesResponseModel({
    required this.status,
    this.addresses,
    this.error,
    this.message,
  });

  factory GetAllAddressesResponseModel.fromJson({required dynamic json}) {
    if (json is List) {
      List<AddressModel> addresses =
          json.map((jsonData) => AddressModel.fromJson(json: jsonData)).toList();
      return GetAllAddressesResponseModel(
        status: true,
        addresses: addresses,
      );
    } else {
      return GetAllAddressesResponseModel(
        status: false,
        error: ErrorModel.fromJson(json['error']),
        message: json['message'],
      );
    }
  }
}
