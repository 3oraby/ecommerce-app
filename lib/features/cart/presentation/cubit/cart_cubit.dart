import 'dart:developer';

import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:e_commerce_app/features/cart/data/models/delete_from_cart_response_model.dart';
import 'package:e_commerce_app/features/cart/data/models/show_cart_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_state.dart';
import 'package:e_commerce_app/features/cart/data/repositories/cart_repository.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository cartRepository;
  List<CartItemModel> _cartItems = [];
  String _cartPrice = "";
  int _totalItemsQuantity = 0;

  CartCubit({required this.cartRepository}) : super(CartInitialState());

  List<CartItemModel> get getCartItems => _cartItems;
  String get getCartPrice => _cartPrice;
  int get getTotalItemsQuantity => _totalItemsQuantity;

  int calculateTotalQuantity(List<CartItemModel> cartItems) {
    return cartItems.fold<int>(0, (sum, item) => sum + item.quantity);
  }

  // Future<void> showCart() async {
  //   emit(ShowCartLoadingState());
  //   try {
  //     final ShowCartResponseModel cart = await cartRepository.showCart();
  //     if (cart.status) {
  //       if (cart.cartItems!.isEmpty) {
  //         emit(EmptyCartState());
  //       } else {
  //         emit(ShowCartLoadedState(cart: cart));
  //       }
  //     } else {
  //       emit(ShowCartErrorState(
  //           message: 'Failed to load cart: ${cart.message}'));
  //     }
  //   } catch (e) {
  //     emit(ShowCartErrorState(message: 'Failed to load cart: $e'));
  //   }
  // }

  // Future<void> addItemToCart(int productId) async {
  //   emit(AddToCartLoadingState());
  //   try {
  //     final AddToCartResponseModel addToCartResponseModel =
  //         await cartRepository.addToCart(productId);
  //     if (addToCartResponseModel.status) {
  //       itemsQuantity += 1;
  //     } else {
  //       emit(const AddToCartErrorState(message: 'Failed to add item to cart'));
  //     }
  //   } catch (e) {
  //     emit(AddToCartErrorState(message: 'Failed to add item to cart: $e'));
  //   }
  // }

  Future<void> deleteItemFromCart(int cartItemId) async {
    emit(DeleteFromCartLoadingState());
    try {
      final DeleteFromCartResponseModel deleteFromCartResponseModel =
          await cartRepository.deleteFromCart(cartItemId);
      if (deleteFromCartResponseModel.status) {
        await showCartAndPrice();
      } else {
        emit(const DeleteFromCartErrorState(
            message: 'Failed to delete item from cart'));
      }
    } catch (e) {
      emit(DeleteFromCartErrorState(
          message: 'Failed to delete item from cart: $e'));
    }
  }

  Future<void> updateCartItem({
    required int cartId,
    required int quantity,
  }) async {
    emit(CartLoadingState());
    try {
      final bool success = await cartRepository.updateCartItem(
        cartId: cartId,
        newQuantity: quantity,
      );
      emit(CartItemUpdatedState(success: success));
      if (success) {
        await showCartAndPrice();
      } else {
        emit(const CartErrorState(message: 'Failed to update item quantity'));
      }
    } catch (e) {
      emit(CartErrorState(message: 'Failed to update item quantity: $e'));
    }
  }

  Future<void> updateCartItemInProductDetails({
    required int productId,
    required int quantity,
  }) async {
    try {
      await cartRepository.updateCartItemInProductDetails(
        productId: productId,
        newQuantity: quantity,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String> loadCartPrice() async {
    try {
      return await cartRepository.showCartPrice();
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  Future<void> showCartAndPrice() async {
    emit(ShowCartLoadingState());
    try {
      final ShowCartResponseModel cart = await cartRepository.showCart();
      final String price = await cartRepository.showCartPrice();

      if (cart.status) {
        _totalItemsQuantity = calculateTotalQuantity(cart.cartItems!);
        _cartItems = cart.cartItems!;
        _cartPrice = price;
        emit(
          CartAndPriceLoadedState(
            cart: cart,
            price: price,
            totalQuantity: _totalItemsQuantity,
          ),
        );
      } else {
        emit(EmptyCartState());
      }
    } catch (e) {
      emit(ShowCartErrorState(message: 'Failed to load cart: $e'));
    }
  }

  Future<void> checkProductInCart(int productId) async {
    emit(CartLoadingState());
    try {
      int? productQuantityInCart;
      final bool inCart = await cartRepository.checkProductInCart(productId);
      if (inCart) {
        productQuantityInCart = await getProductQuantityInCart(productId);
      }

      emit(CheckProductInCartLoadedState(
        inCart: inCart,
        productQuantityInCart: productQuantityInCart,
      ));
    } catch (e) {
      emit(CartErrorState(message: 'Failed to delete item from cart: $e'));
    }
  }

  Future<int> getProductQuantityInCart(int productId) async {
    try {
      ShowCartResponseModel showCartResponseModel =
          await cartRepository.showCart();

      if (showCartResponseModel.status) {
        CartItemModel cartItemModel =
            showCartResponseModel.cartItems!.firstWhere(
          (item) => item.productId == productId,
        );

        return cartItemModel.quantity;
      } else {
        throw Exception(showCartResponseModel.message);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
