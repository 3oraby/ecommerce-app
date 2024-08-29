import 'package:e_commerce_app/features/address/data/models/get_all_addresses_response_model.dart';
import 'package:e_commerce_app/features/address/data/models/save_user_address_model.dart';
import 'package:e_commerce_app/features/address/data/repositories/addresses_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'addresses_state.dart';

class AddressesCubit extends Cubit<AddressesState> {
  final AddressesRepository addressesRepository;
  late SaveUserAddressModel saveUserAddressModel;

  AddressesCubit({
    required this.addressesRepository,
  }) : super(AddressesInitialState());

  void setUserAddress(SaveUserAddressModel address) {
    saveUserAddressModel = address;
  }

  SaveUserAddressModel get getUserAddress => saveUserAddressModel;

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
}