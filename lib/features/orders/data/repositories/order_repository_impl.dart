import 'package:e_commerce_app/features/orders/data/data_sources/cancel_item_from_order_service.dart';
import 'package:e_commerce_app/features/orders/data/data_sources/checkout_service.dart';
import 'package:e_commerce_app/features/orders/data/data_sources/get_all_orders_service.dart';
import 'package:e_commerce_app/features/orders/data/data_sources/get_order_data_service.dart';
import 'package:e_commerce_app/features/orders/data/models/checkout_response_model.dart';
import 'package:e_commerce_app/features/orders/data/models/get_all_orders_response_model.dart';
import 'package:e_commerce_app/features/orders/data/models/get_order_response_model.dart';
import 'package:e_commerce_app/features/orders/data/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl({
    required this.checkoutService,
    required this.getOrderDataService,
    required this.getAllOrdersService,
    required this.cancelItemFromOrderService,
  });

  final CheckoutService checkoutService;
  final GetOrderDataService getOrderDataService;
  final GetAllOrdersService getAllOrdersService;
  final CancelItemFromOrderService cancelItemFromOrderService;

  @override
  Future<CheckoutResponseModel> checkout(Map<String, dynamic> jsonData) async {
    return await checkoutService.checkout(jsonData: jsonData);
  }

  @override
  Future<GetOrderResponseModel> getOrderData(int orderId) async {
    return await getOrderDataService.getOrder(orderId: orderId);
  }

  @override
  Future<GetAllOrdersResponseModel> getAllOrdersData(int userId) async {
    return await getAllOrdersService.getAllOrder(userId: userId);
  }

  @override
  Future<bool> cancelItemFromOrder(
      {required int orderId, required int orderItemId}) async {
    return await cancelItemFromOrderService.cancelItem(
        orderId: orderId, orderItemId: orderItemId);
  }
}
