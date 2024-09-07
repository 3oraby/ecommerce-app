import 'package:e_commerce_app/features/orders/data/models/checkout_response_model.dart';
import 'package:e_commerce_app/features/orders/data/models/get_all_orders_response_model.dart';
import 'package:e_commerce_app/features/orders/data/models/get_order_response_model.dart';

abstract class OrderRepository {
  Future<CheckoutResponseModel> checkout(Map<String, dynamic> jsonData);
  
  Future<GetOrderResponseModel> getOrderData(int orderId);

  Future<GetAllOrdersResponseModel> getAllOrdersData(int userId);
}
