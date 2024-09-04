import 'package:e_commerce_app/features/orders/data/data_sources/checkout_service.dart';
import 'package:e_commerce_app/features/orders/data/data_sources/get_order_data_service.dart';
import 'package:e_commerce_app/features/orders/data/models/checkout_response_model.dart';
import 'package:e_commerce_app/features/orders/data/models/get_order_response_model.dart';
import 'package:e_commerce_app/features/orders/data/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl({
    required this.checkoutService,
    required this.getOrderDataService,
  });

  final CheckoutService checkoutService;
  final GetOrderDataService getOrderDataService;

  @override
  Future<CheckoutResponseModel> checkout(Map<String, dynamic> jsonData) async {
    return await checkoutService.checkout(jsonData: jsonData);
  }

  @override
  Future<GetOrderResponseModel> getOrderData(int orderId) async {
    return await getOrderDataService.getOrder(orderId: orderId);
  }
}
