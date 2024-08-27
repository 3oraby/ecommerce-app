import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/features/address/presentation/cubit/addresses_cubit.dart';
import 'package:e_commerce_app/features/address/presentation/widgets/add_address_widgets/add_address_loaded_body.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});
  static const id = "/add_address_page";

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  @override
  Widget build(BuildContext context) {
    List<CartItemModel> cartItems =
        ModalRoute.of(context)!.settings.arguments as List<CartItemModel>;

    return Scaffold(
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
          "Add new address",
          style: TextStyles.aDLaMDisplayBlackBold22,
        ),
      ),
      body: BlocBuilder<AddressesCubit, AddressesState>(
        builder: (context, state) {
          if (state is AddressesInitialState) {
            context.read<AddressesCubit>().getAllAddresses();
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AddressesLoadedState) {
            return AddAddressLoadedBody(
              getAllAddressesResponseModel:
                  state.getAllAddressesResponseModel,
              cartItems : cartItems,    
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
