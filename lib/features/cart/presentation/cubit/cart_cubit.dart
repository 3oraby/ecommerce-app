import 'dart:developer';

import 'package:e_commerce_app/core/helpers/functions/check_connection_with_internet.dart';
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
  final List<int> _itemsWillBeDeleted = [];
  final List<int> _itemsWillMoveToFavorites = [];

  CartCubit({required this.cartRepository}) : super(CartInitialState());

  List<CartItemModel> get getCartItems => _cartItems;
  String get getCartPrice => _cartPrice;
  int get getTotalItemsQuantity => _totalItemsQuantity;
  List<int> get getItemsWillBeDeleted => _itemsWillBeDeleted;
  List<int> get getItemsWillMoveToFavorites => _itemsWillMoveToFavorites;

  int calculateTotalQuantity(List<CartItemModel> cartItems) {
    return cartItems.fold<int>(0, (sum, item) => sum + item.quantity);
  }

  void refreshPage() {
    emit(CartRefreshPageState());
  }

  Future<void> moveItemToFavorites(int cartItemId) async {
    if (!await checkConnectionWithInternet()) {
      emit(MoveToFavoritesNoNetworkErrorState(cartItemId: cartItemId));
      return;
    }
    emit(MoveToFavoritesLoadingState());
    try {
      _itemsWillMoveToFavorites.add(cartItemId);
      final DeleteFromCartResponseModel deleteFromCartResponseModel =
          await cartRepository.deleteFromCart(cartItemId);
      if (deleteFromCartResponseModel.status) {
        emit(MoveToFavoritesLoadedState());
        _itemsWillMoveToFavorites.remove(cartItemId);

        await showCartAndPrice();
      } else {
        _itemsWillMoveToFavorites.remove(cartItemId);
        emit(const MoveToFavoritesErrorState(
            message: 'Failed to move item to favorites'));
      }
    } catch (e) {
      _itemsWillMoveToFavorites.remove(cartItemId);
      emit(MoveToFavoritesErrorState(
          message: 'Failed to move item to favorites: $e'));
    }
  }

  Future<void> deleteItemFromCart(int cartItemId) async {
    if (!await checkConnectionWithInternet()) {
      emit(DeleteCartNoNetworkErrorState(cartItemId: cartItemId));
      return;
    }
    emit(DeleteFromCartLoadingState());
    try {
      _itemsWillBeDeleted.add(cartItemId);
      final DeleteFromCartResponseModel deleteFromCartResponseModel =
          await cartRepository.deleteFromCart(cartItemId);
      if (deleteFromCartResponseModel.status) {
        emit(DeleteFromCartLoadedState());
        _itemsWillBeDeleted.remove(cartItemId);

        await showCartAndPrice();
      } else {
        _itemsWillBeDeleted.remove(cartItemId);
        emit(const DeleteFromCartErrorState(
            message: 'Failed to delete item from cart'));
      }
    } catch (e) {
      _itemsWillBeDeleted.remove(cartItemId);
      emit(DeleteFromCartErrorState(
          message: 'Failed to delete item from cart: $e'));
    }
  }

  Future<void> updateCartItem({
    required int quantity,
    int? cartId,
    int? productId,
  }) async {
    if (!await checkConnectionWithInternet()) {
      emit(UpdateCartNoNetworkErrorState());
      return;
    }
    emit(CartItemUpdatedLoadingState(cartId: cartId));
    try {
      final bool success = await cartRepository.updateCartItem(
        cartId: cartId,
        productId: productId,
        newQuantity: quantity,
      );
      emit(CartItemUpdatedLoadedState(success: success));
      if (success) {
        await showCartAndPrice();
      } else {
        emit(CartItemUpdatedErrorState(
            message: 'Failed to update item quantity'));
      }
    } catch (e) {
      emit(CartItemUpdatedErrorState(
        message: 'Failed to update item quantity: $e',
      ));
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
    if (!await checkConnectionWithInternet()) {
      emit(CartNoNetworkErrorState());
      return;
    }
    emit(ShowCartLoadingState());
    try {
      final ShowCartResponseModel cart = await cartRepository.showCart();
      final String price = await cartRepository.showCartPrice();

      if (cart.status) {
        if (cart.cartItems!.isEmpty) {
          emit(EmptyCartState());
        } else {
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
        }
      } else {
        emit(ShowCartErrorState(message: cart.message!));
      }
    } catch (e) {
      emit(ShowCartErrorState(message: 'Failed to load cart: $e'));
    }
  }

  Future<void> checkProductInCart(int productId) async {
    if (!await checkConnectionWithInternet()) {
      emit(CartNoNetworkErrorState());
      return;
    }
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
