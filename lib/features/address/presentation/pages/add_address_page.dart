import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_no_internet_connection_body.dart';
import 'package:e_commerce_app/features/address/presentation/cubit/addresses_cubit.dart';
import 'package:e_commerce_app/features/address/presentation/widgets/add_address_widgets/add_address_loaded_body.dart';
import 'package:e_commerce_app/features/auth/presentation/pages/entry_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddressPage extends StatelessWidget {
  const AddAddressPage({super.key});
  static const id = "/add_address_page";

  @override
  Widget build(BuildContext context) {
    final AddressesCubit addressesCubit =
        BlocProvider.of<AddressesCubit>(context);
    addressesCubit.getAllAddresses();

    return Scaffold(
      backgroundColor: ThemeColors.backgroundBodiesColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              String? lastRoute = SharedPreferencesSingleton.getString(
                  LocalConstants.lastRouteIdInPref);
              if (lastRoute == null) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  EntryPage.id,
                  (Route<dynamic> route) => false,
                );
              } else {
                Navigator.pop(context, true);
              }
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        title: Text(
          "Add address",
          style: TextStyles.aDLaMDisplayBlackBold22,
        ),
      ),
      body: BlocBuilder<AddressesCubit, AddressesState>(
        buildWhen: (previous, current) {
          return current is GetAddressesLoadingState ||
              current is GetAddressesLoadedState ||
              current is GetAddressesErrorState ||
              current is AddressesNoNetworkConnectionState;
        },
        builder: (context, state) {
          if (state is GetAddressesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetAddressesLoadedState) {
            return AddAddressLoadedBody(
              getAllAddressesResponseModel: state.getAllAddressesResponseModel,
            );
          } else if (state is GetAddressesErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is AddressesNoNetworkConnectionState) {
            return CustomNoInternetConnectionBody(onTryAgainPressed: () {
              addressesCubit.getAllAddresses();
            });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
