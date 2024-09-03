import 'dart:developer';

import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
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
    BlocProvider.of<AddressesCubit>(context).getOrdersAddresses();
    return Scaffold(
      backgroundColor: ThemeColors.backgroundBodiesColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                final isRefresh =
                    await Navigator.pushNamed(context, AddAddressPage.id);
                log("isRefresh +$isRefresh");
                if (isRefresh is bool && isRefresh == true) {
                  BlocProvider.of<AddressesCubit>(context).getOrdersAddresses();
                }
              },
            );
          } else if (state is AddressesErrorState) {
            return Center(
              child: Text(state.message),
            );
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
