
import 'package:e_commerce_app/features/orders/data/models/checkout_response_model.dart';
import 'package:e_commerce_app/features/orders/data/models/get_all_orders_response_model.dart';
import 'package:e_commerce_app/features/orders/data/models/order_model.dart';
import 'package:e_commerce_app/features/orders/data/repositories/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository orderRepository;
  OrderCubit({
    required this.orderRepository,
  }) : super(OrderInitial());

  CheckoutResponseModel? checkoutResponseModel;
  int totalOrders = 0;

  void setCheckoutResponseModel(CheckoutResponseModel address) {
    checkoutResponseModel = address;
  }

  void increaseOrdersCount() {
    totalOrders++;
  }

  void decreaseOrdersCount() {
    totalOrders--;
  }

  int get getTotalOrdersCount => totalOrders;
  CheckoutResponseModel? get getCheckoutResponseModel => checkoutResponseModel;

  Future<CheckoutResponseModel> confirmOrder(
      {required Map<String, dynamic> jsonData}) async {
    try {
      CheckoutResponseModel checkoutResponseModel =
          await orderRepository.checkout(jsonData);
      if (checkoutResponseModel.status) {
        return checkoutResponseModel;
      } else {
        throw Exception(checkoutResponseModel.message);
      }
    } catch (error) {
      throw Exception('Failed to confirm order');
    }
  }

  Future<void> getAllOrders(int userId) async {
    emit(GetAllOrdersLoadingState());
    try {
      GetAllOrdersResponseModel getAllOrdersResponseModel =
          await orderRepository.getAllOrdersData(userId);
      if (getAllOrdersResponseModel.status) {
        emit(GetAllOrdersLoadedState(
            userOrders: getAllOrdersResponseModel.userOrders!));
      } else {
        emit(GetAllOrdersErrorState(
            message: getAllOrdersResponseModel.message!));
      }
    } catch (e) {
      emit(GetAllOrdersErrorState(message: e.toString()));
    }
  }
}
