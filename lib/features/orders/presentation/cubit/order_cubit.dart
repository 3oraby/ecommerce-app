import 'dart:developer';

import 'package:e_commerce_app/features/orders/data/models/checkout_response_model.dart';
import 'package:e_commerce_app/features/orders/data/models/get_all_orders_response_model.dart';
import 'package:e_commerce_app/features/orders/data/models/order_items_model.dart';
import 'package:e_commerce_app/features/orders/data/models/order_model.dart';
import 'package:e_commerce_app/features/orders/data/repositories/order_repository.dart';
import 'package:e_commerce_app/features/orders/presentation/cubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository orderRepository;

  OrderCubit({required this.orderRepository}) : super(OrderInitial());

  CheckoutResponseModel? checkoutResponseModel;
  OrderModel? selectedOrder;
  OrderItemModel? selectedOrderItemModel;

  int totalOrders = 0;

  void setCheckoutResponseModel(CheckoutResponseModel model) {
    checkoutResponseModel = model;
  }

  void setOrderModel(OrderModel order) {
    selectedOrder = order;
  }

  void setOrderItemModel(OrderItemModel order) {
    selectedOrderItemModel = order;
  }

  void increaseOrdersCount() {
    totalOrders++;
  }

  void decreaseOrdersCount() {
    totalOrders--;
  }

  int get getTotalOrdersCount => totalOrders;
  CheckoutResponseModel? get getCheckoutResponseModel => checkoutResponseModel;
  OrderModel? get getSelectedOrderModel => selectedOrder;
  OrderItemModel? get getSelectedOrderItemModel => selectedOrderItemModel;
  int get getSelectedItemsCountForCancellation {
    return selectedItemsForCancellation.values
        .where((isSelected) => isSelected)
        .length;
  }

  Map<OrderItemModel, bool> selectedItemsForCancellation = {};

  void toggleOrderItemSelectionForCancellation(OrderItemModel item) {
    final isSelected = selectedItemsForCancellation[item] ?? false;
    selectedItemsForCancellation[item] = !isSelected;
  }

  Future<void> cancelSelectedItems() async {
    final List<OrderItemModel> selectedItems = selectedItemsForCancellation
        .entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();

    if (selectedItems.isNotEmpty) {
      emit(CancelItemFromOrderLoadingState());

      try {
        for (var orderItem in selectedItems) {
          final bool itemCancelled = await orderRepository.cancelItemFromOrder(
            orderId: selectedOrder!.id,
            orderItemId: orderItem.id,
          );

          if (!itemCancelled) {
            emit(CancelItemFromOrderErrorState(
                message: "Cannot cancel item with id: ${orderItem.id}"));
            return;
          }
        }

        emit(CancelItemFromOrderLoadedState());
        resetSelectedItemsForCancellation();
      } catch (e) {
        log(e.toString());
        emit(CancelItemFromOrderErrorState(
            message: "Error occurred while cancelling items."));
      }
    } else {
      emit(CancelItemFromOrderErrorState(
          message: 'No items selected for cancellation.'));
    }
  }

  bool isOrderItemSelectedForCancellation(OrderItemModel item) {
    return selectedItemsForCancellation[item] ?? false;
  }

  void resetSelectedItemsForCancellation() {
    selectedItemsForCancellation.clear();
  }

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
      log(error.toString());
      throw Exception('Failed to confirm order');
    }
  }

  Future<void> getAllOrders(int userId) async {
    emit(GetAllOrdersLoadingState());
    try {
      GetAllOrdersResponseModel getAllOrdersResponseModel =
          await orderRepository.getAllOrdersData(userId);
      if (getAllOrdersResponseModel.status) {
        if (getAllOrdersResponseModel.userOrders!.isEmpty) {
          emit(GetAllOrdersEmptyState());
        } else {
          List<OrderModel> completedOrders = [];
          List<OrderModel> inProgressOrders = [];

          for (OrderModel order in getAllOrdersResponseModel.userOrders!) {
            if (order.orderStateModel.state == 'canceled' ||
                order.orderStateModel.state == 'recieved') {
              completedOrders.add(order);
            } else if (order.orderStateModel.state == 'inProgress') {
              inProgressOrders.add(order);
            }
          }

          emit(GetAllOrdersLoadedState(
            completedOrders: completedOrders,
            inProgressOrders: inProgressOrders,
          ));
        }
      } else {
        emit(GetAllOrdersErrorState(
            message: getAllOrdersResponseModel.message!));
      }
    } catch (e) {
      emit(GetAllOrdersErrorState(message: e.toString()));
    }
  }
}
