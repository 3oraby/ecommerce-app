import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';
import 'package:e_commerce_app/features/address/data/models/get_orders_addresses_response_model.dart';

class GetAllOrdersAddressesService {
  Future<GetOrdersAddressesResponseModel> getOrdersAddresses() async {
    try {
      Response response = await Api().get(
        url:
            "${ApiConstants.baseUrl}${ApiConstants.getOrdersAddressesEndPoint}",
      );
      return GetOrdersAddressesResponseModel.fromJson(json: response.data);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
