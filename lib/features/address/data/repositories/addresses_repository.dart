import 'package:e_commerce_app/features/address/data/models/get_all_addresses_response_model.dart';
import 'package:e_commerce_app/features/address/data/models/get_orders_addresses_response_model.dart';

abstract class AddressesRepository {
  Future<GetAllAddressesResponseModel> getAllAddresses();

  Future<GetOrdersAddressesResponseModel> getOrdersAddresses();
}
