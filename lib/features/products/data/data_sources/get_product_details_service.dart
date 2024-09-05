// import 'package:dio/dio.dart';
// import 'package:e_commerce_app/constants/api_constants.dart';
// import 'package:e_commerce_app/core/helpers/api.dart';
// import 'package:e_commerce_app/features/products/data/models/get_product_response_model.dart';

// class GetProductDetailsService {
//   Future<GetProductResponseModel> getProductDetails({
//     required int productId,
//   }) async {
//     try {
//       Response response = await Api().get(
//         url:
//             "${ApiConstants.baseUrl}${ApiConstants.getProductDetailsEndPoint}$productId",
//       );
//       return GetProductResponseModel.fromJson(json: response.data);
//     } on Exception catch (e) {
//       throw Exception(e);
//     }
//   }
// }
