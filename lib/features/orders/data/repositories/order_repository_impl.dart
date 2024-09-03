import 'package:e_commerce_app/features/orders/data/data_sources/checkout_service.dart';
import 'package:e_commerce_app/features/orders/data/models/checkout_response_model.dart';
import 'package:e_commerce_app/features/orders/data/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl({
    required this.checkoutService,
  });

  final CheckoutService checkoutService;

  @override
  Future<CheckoutResponseModel> checkout(Map<String, dynamic> jsonData) async {
    return await checkoutService.checkout(jsonData: jsonData);
  }
}
