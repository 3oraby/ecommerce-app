import 'dart:developer';

import 'package:e_commerce_app/features/address/data/models/get_all_addresses_response_model.dart';
import 'package:e_commerce_app/features/address/data/models/get_orders_addresses_response_model.dart';
import 'package:e_commerce_app/features/address/data/models/orders_address_model.dart';
import 'package:e_commerce_app/features/address/data/repositories/addresses_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'addresses_state.dart';

class AddressesCubit extends Cubit<AddressesState> {
  final AddressesRepository addressesRepository;
  OrdersAddressModel? orderAddressChosen;
  OrdersAddressModel? userHomeAddress;

  AddressesCubit({
    required this.addressesRepository
  }) : super(AddressesInitialState());

  void setUserHomeAddress(OrdersAddressModel address) {
    userHomeAddress = address;
  }
  void setOrderAddressChosen(OrdersAddressModel address) {
    orderAddressChosen = address;
  }

  OrdersAddressModel? get getUserHomeAddress => userHomeAddress;
  OrdersAddressModel? get getOrderAddressChosen => orderAddressChosen ?? userHomeAddress;

  Future<void> getAllAddresses() async {
    emit(AddressesLoadingState());
    try {
      final GetAllAddressesResponseModel getAllAddressesResponseModel =
          await addressesRepository.getAllAddresses();

      emit(AddressesLoadedState(
          getAllAddressesResponseModel: getAllAddressesResponseModel));
    } catch (e) {
      emit(AddressesErrorState(
        message: 'Failed to fetch favorites: $e',
      ));
    }
  }

  Future<void> getOrdersAddresses() async {
    log("get orders addresses");
    emit(AddressesLoadingState());
    try {
      final GetOrdersAddressesResponseModel getOrdersAddressesResponseModel =
          await addressesRepository.getOrdersAddresses();

      if (getOrdersAddressesResponseModel.status) {
        emit(OrderAddressesLoadedState(
            getOrdersAddressesResponseModel: getOrdersAddressesResponseModel));
      } else {
        emit(AddressesErrorState(
            message: getOrdersAddressesResponseModel.message!));
      }
    } catch (e) {
      emit(AddressesErrorState(
        message: 'Failed to fetch Addresses: $e',
      ));
    }
  }
}
