import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce_app/features/address/data/models/orders_address_model.dart';

OrdersAddressModel? getUserHomeAddress() {
  try {
    String? jsonString =
        SharedPreferencesSingleton.getString(LocalConstants.userAddressModelInPref);
    if (jsonString != null && jsonString.isNotEmpty) {
      return OrdersAddressModel.fromJson(jsonDecode(jsonString));
    }
    return null;
  } catch (e) {
    log("Error decoding home address: $e");
    throw Exception("Error decoding home address: $e");
  }
}
