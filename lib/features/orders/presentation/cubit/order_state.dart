import 'package:e_commerce_app/features/orders/data/models/checkout_response_model.dart';
import 'package:e_commerce_app/features/orders/data/models/order_model.dart';

abstract class OrderState {}

final class OrderInitial extends OrderState {}

final class CheckoutLoadingState extends OrderState {}

final class CheckoutErrorState extends OrderState {
  final String message;
  CheckoutErrorState({required this.message});
}

final class CheckoutLoadedState extends OrderState {
  final CheckoutResponseModel checkoutResponseModel;
  CheckoutLoadedState({required this.checkoutResponseModel});
}

final class GetAllOrdersLoadingState extends OrderState {}

final class GetAllOrdersEmptyState extends OrderState {}

final class GetAllOrdersErrorState extends OrderState {
  final String message;
  GetAllOrdersErrorState({required this.message});
}

final class GetAllOrdersLoadedState extends OrderState {
  final List<OrderModel> completedOrders;
  final List<OrderModel> inProgressOrders;
  GetAllOrdersLoadedState({
    required this.completedOrders,
    required this.inProgressOrders,
  });
}

final class OrderNoInternetConnectionState extends OrderState {}

final class CancelItemFromOrderLoadingState extends OrderState {}

final class CancelItemFromOrderLoadedState extends OrderState {}

final class CancelItemFromOrderErrorState extends OrderState {
  final String message;
  CancelItemFromOrderErrorState({required this.message});
}

final class MakeOrderLoadingState extends OrderState {}

final class MakeOrderLoadedState extends OrderState {}

final class MakeOrderErrorState extends OrderState {
  final String message;
  MakeOrderErrorState({required this.message});
}
