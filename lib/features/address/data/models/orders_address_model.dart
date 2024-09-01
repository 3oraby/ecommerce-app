import 'package:e_commerce_app/features/address/data/models/address_model.dart';

class OrdersAddressModel {
  final String addressInDetails;
  final AddressModel address;

  OrdersAddressModel({required this.addressInDetails, required this.address});

  factory OrdersAddressModel.fromJson(Map<String, dynamic> json) {
    return OrdersAddressModel(
      addressInDetails: json["addressInDetails"],
      address: AddressModel.fromJson(
        json: json["Address"],
      ),
    );
  }
}
