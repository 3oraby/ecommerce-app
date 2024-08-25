
import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/helpers/api.dart';
import 'package:e_commerce_app/features/address/data/models/get_all_addresses_response_model.dart';

class GetAllAddressesService {
   Future<GetAllAddressesResponseModel> getAllAddresses() async {
    try {
      Response response = await Api().get(
        url: "${ApiConstants.baseUrl}${ApiConstants.getAllAddressesEndPoint}",
      );
      return GetAllAddressesResponseModel.fromJson(json: response.data);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
