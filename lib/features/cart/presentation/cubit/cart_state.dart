import 'package:e_commerce_app/features/cart/data/models/show_cart_response_model.dart';

abstract class CartState {
  const CartState();
}

// Initial state
class CartInitialState extends CartState {}

// General Loading State (if needed)
class CartLoadingState extends CartState {}

// Loading and error states for adding to cart
class AddToCartLoadingState extends CartState {}

class AddToCartErrorState extends CartState {
  final String message;
  const AddToCartErrorState({required this.message});
}

// Loading and error states for deleting from cart
class DeleteFromCartLoadingState extends CartState {}

class DeleteFromCartErrorState extends CartState {
  final String message;
  const DeleteFromCartErrorState({required this.message});
}

// Loading and error states for showing the cart
class ShowCartLoadingState extends CartState {}

class ShowCartErrorState extends CartState {
  final String message;
  const ShowCartErrorState({required this.message});
}

class EmptyCartState extends CartState {}

class CartAndPriceLoadedState extends CartState {
  final String price;
  final ShowCartResponseModel cart;
  final int totalQuantity;

  CartAndPriceLoadedState(
      {required this.price, required this.cart, required this.totalQuantity});
}

// States for successful operations
class CartErrorState extends CartState {
  final String message;
  const CartErrorState({required this.message});
}

class ShowCartLoadedState extends CartState {
  final ShowCartResponseModel cart;
  const ShowCartLoadedState({required this.cart});
}

class CartItemUpdatedState extends CartState {
  final bool success;
  const CartItemUpdatedState({required this.success});
}

class CartPriceLoadedState extends CartState {
  final String price;
  const CartPriceLoadedState({required this.price});
}

class CheckProductInCartLoadedState extends CartState {
  final bool inCart;
  const CheckProductInCartLoadedState(this.inCart);
}