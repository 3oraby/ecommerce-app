import 'package:e_commerce_app/features/address/data/data_sources/get_all_addresses_service.dart';
import 'package:e_commerce_app/features/address/data/data_sources/get_all_orders_addresses_service.dart';
import 'package:e_commerce_app/features/address/data/models/get_all_addresses_response_model.dart';
import 'package:e_commerce_app/features/address/data/models/get_orders_addresses_response_model.dart';
import 'package:e_commerce_app/features/address/data/repositories/addresses_repository.dart';

class AddressesRepositoryImpl implements AddressesRepository {
  final GetAllAddressesService getAllAddressesService;
  final GetAllOrdersAddressesService getAllOrdersAddressesService;
  AddressesRepositoryImpl({
    required this.getAllAddressesService,
    required this.getAllOrdersAddressesService,
  });

  @override
  Future<GetAllAddressesResponseModel> getAllAddresses() async {
    return await getAllAddressesService.getAllAddresses();
  }

  @override
  Future<GetOrdersAddressesResponseModel> getOrdersAddresses() async {
    return await getAllOrdersAddressesService.getOrdersAddresses();
  }
}
