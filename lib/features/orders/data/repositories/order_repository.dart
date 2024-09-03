import 'package:e_commerce_app/features/orders/data/models/checkout_response_model.dart';

abstract class OrderRepository {
  Future<CheckoutResponseModel> checkout(Map<String, dynamic> jsonData);
}
