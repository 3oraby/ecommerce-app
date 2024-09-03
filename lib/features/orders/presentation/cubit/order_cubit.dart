import 'package:e_commerce_app/features/orders/data/models/checkout_response_model.dart';
import 'package:e_commerce_app/features/orders/data/repositories/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository orderRepository;
  OrderCubit({
    required this.orderRepository,
  }) : super(OrderInitial());

  CheckoutResponseModel? checkoutResponseModel;
  void setCheckoutResponseModel(CheckoutResponseModel address) {
    checkoutResponseModel = address;
  }

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
}
