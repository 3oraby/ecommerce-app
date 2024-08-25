part of 'addresses_cubit.dart';

abstract class AddressesState {}

final class AddressesInitialState extends AddressesState {}

final class AddressesLoadedState extends AddressesState {
  final GetAllAddressesResponseModel getAllAddressesResponseModel;
  AddressesLoadedState({
    required this.getAllAddressesResponseModel,
  });
}

final class AddressesLoadingState extends AddressesState {}

final class AddressesErrorState extends AddressesState {
  final String message;
  AddressesErrorState({required this.message});
}
