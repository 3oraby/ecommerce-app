import 'package:e_commerce_app/features/address/data/models/save_user_address_model.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';

class CheckoutPageArgumentsModel {
  final List<CartItemModel> cartItems;
  final SaveUserAddressModel saveUserAddressModel;

  CheckoutPageArgumentsModel({
    required this.cartItems,
    required this.saveUserAddressModel,
  });
}
