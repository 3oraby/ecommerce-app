part of 'order_cubit.dart';

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

final class GetAllOrdersErrorState extends OrderState {
  final String message;
  GetAllOrdersErrorState({required this.message});
}

final class GetAllOrdersLoadedState extends OrderState {
  final List<OrderModel> userOrders;
  GetAllOrdersLoadedState({required this.userOrders});
}
