import 'package:e_commerce_app/core/helpers/functions/check_connection_with_internet.dart';
import 'package:e_commerce_app/features/address/data/models/get_all_addresses_response_model.dart';
import 'package:e_commerce_app/features/address/data/models/get_orders_addresses_response_model.dart';
import 'package:e_commerce_app/features/address/data/models/orders_address_model.dart';
import 'package:e_commerce_app/features/address/data/repositories/addresses_repository.dart';
import 'package:e_commerce_app/features/address/presentation/utils/get_user_home_address.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'addresses_state.dart';

class AddressesCubit extends Cubit<AddressesState> {
  final AddressesRepository addressesRepository;
  OrdersAddressModel? orderAddressChosen;

  AddressesCubit({required this.addressesRepository})
      : super(AddressesInitialState());

  void setOrderAddressChosen(OrdersAddressModel address) {
    orderAddressChosen = address;
  }

  OrdersAddressModel? get getOrderAddressChosen =>
      orderAddressChosen ?? getUserHomeAddress();

  Future<void> getAllAddresses() async {
    if (!await checkConnectionWithInternet()) {
      emit(AddressesNoNetworkConnectionState());
      return;
    }
    emit(GetAddressesLoadingState());
    try {
      final GetAllAddressesResponseModel getAllAddressesResponseModel =
          await addressesRepository.getAllAddresses();

      emit(GetAddressesLoadedState(
          getAllAddressesResponseModel: getAllAddressesResponseModel));
    } catch (e) {
      emit(GetAddressesErrorState(
        message: 'Failed to fetch favorites: $e',
      ));
    }
  }

  Future<void> getOrdersAddresses() async {
    if (!await checkConnectionWithInternet()) {
      emit(AddressesNoNetworkConnectionState());
      return;
    }
    emit(OrderAddressesLoadingState());
    try {
      final GetOrdersAddressesResponseModel getOrdersAddressesResponseModel =
          await addressesRepository.getOrdersAddresses();

      if (getOrdersAddressesResponseModel.status) {
        emit(OrderAddressesLoadedState(
            getOrdersAddressesResponseModel: getOrdersAddressesResponseModel));
      } else {
        emit(OrderAddressesErrorState(
            message: getOrdersAddressesResponseModel.message!));
      }
    } catch (e) {
      emit(OrderAddressesErrorState(
        message: 'Failed to fetch Addresses: $e',
      ));
    }
  }
}
