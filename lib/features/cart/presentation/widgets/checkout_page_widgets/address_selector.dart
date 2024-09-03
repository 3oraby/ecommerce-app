import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/features/address/data/models/orders_address_model.dart';
import 'package:e_commerce_app/features/address/presentation/cubit/addresses_cubit.dart';
import 'package:e_commerce_app/features/address/presentation/pages/choose_address_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressSelector extends StatefulWidget {
  const AddressSelector({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  State<AddressSelector> createState() => _AddressSelectorState();
}

class _AddressSelectorState extends State<AddressSelector> {
  late OrdersAddressModel ordersAddressModel;
  @override
  void initState() {
    super.initState();
    ordersAddressModel =
        BlocProvider.of<AddressesCubit>(context).getOrderAddressChosen ??
            BlocProvider.of<AddressesCubit>(context).getUserHomeAddress!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final isRefresh =
            await Navigator.pushNamed(context, ChooseAddressPage.id);
        if (isRefresh is bool && isRefresh == true) {
          setState(() {
            ordersAddressModel =
                BlocProvider.of<AddressesCubit>(context).getOrderAddressChosen!;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 0.2,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: Colors.grey,
              size: 28,
            ),
            const HorizontalGap(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Deliver to",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    ordersAddressModel.addressInDetails!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  )
                ],
              ),
            ),
            const HorizontalGap(8),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
