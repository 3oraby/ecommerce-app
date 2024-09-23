import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/address/presentation/cubit/addresses_cubit.dart';
import 'package:e_commerce_app/features/address/presentation/widgets/add_address_widgets/add_address_loaded_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddressPage extends StatelessWidget {
  const AddAddressPage({super.key});
  static const id = "/add_address_page";

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AddressesCubit>(context).getAllAddresses();

    return Scaffold(
      backgroundColor: ThemeColors.backgroundBodiesColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
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
        builder: (context, state) {
          if (state is AddressesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AddressesLoadedState) {
            return AddAddressLoadedBody(
              getAllAddressesResponseModel: state.getAllAddressesResponseModel,
            );
          } else if (state is AddressesErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text("there is no addresses"),
            );
          }
        },
      ),
    );
  }
}
