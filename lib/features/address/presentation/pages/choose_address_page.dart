import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_no_internet_connection_body.dart';
import 'package:e_commerce_app/features/address/presentation/cubit/addresses_cubit.dart';
import 'package:e_commerce_app/features/address/presentation/pages/add_address_page.dart';
import 'package:e_commerce_app/features/address/presentation/widgets/choose_address_widgets/choose_address_loaded_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseAddressPage extends StatelessWidget {
  const ChooseAddressPage({super.key});
  static const id = "/choose_address_page";

  @override
  Widget build(BuildContext context) {
    final AddressesCubit addressesCubit =
        BlocProvider.of<AddressesCubit>(context);
    addressesCubit.getOrdersAddresses();
    return Scaffold(
      backgroundColor: ThemeColors.backgroundBodiesColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
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
          "Your addresses",
          style: TextStyles.aDLaMDisplayBlackBold22,
        ),
      ),
      body: BlocBuilder<AddressesCubit, AddressesState>(
        builder: (context, state) {
          if (state is OrderAddressesLoadedState) {
            return ChooseAddressLoadedBody(
              getOrdersAddressesResponseModel:
                  state.getOrdersAddressesResponseModel,
              onAddAddressButtonPressed: () async {
                SharedPreferencesSingleton.setString(
                    LocalConstants.lastRouteIdInPref, ChooseAddressPage.id);
                final isRefresh =
                    await Navigator.pushNamed(context, AddAddressPage.id);

                if (isRefresh is bool && isRefresh == true) {
                  addressesCubit.getOrdersAddresses();
                }
              },
            );
          } else if (state is OrderAddressesErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is AddressesNoNetworkConnectionState) {
            return CustomNoInternetConnectionBody(onTryAgainPressed: () {
              addressesCubit.getOrdersAddresses();
            });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
