part of 'addresses_cubit.dart';

abstract class AddressesState {}

final class AddressesInitialState extends AddressesState {}

final class AddressesNoNetworkConnectionState extends AddressesState {}

final class OrderAddressesLoadingState extends AddressesState {}

final class OrderAddressesErrorState extends AddressesState {
  final String message;
  OrderAddressesErrorState({required this.message});
}

final class OrderAddressesLoadedState extends AddressesState {
  final GetOrdersAddressesResponseModel getOrdersAddressesResponseModel;
  OrderAddressesLoadedState({
    required this.getOrdersAddressesResponseModel,
  });
}

final class OrderAddressesEmptyState extends AddressesState {}

final class GetAddressesLoadingState extends AddressesState {}

final class GetAddressesLoadedState extends AddressesState {
  final GetAllAddressesResponseModel getAllAddressesResponseModel;
  GetAddressesLoadedState({required this.getAllAddressesResponseModel});
}

final class GetAddressesErrorState extends AddressesState {
  final String message;
  GetAddressesErrorState({required this.message});
}
