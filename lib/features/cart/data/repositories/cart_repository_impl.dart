import 'package:e_commerce_app/features/cart/data/data_sources/add_to_cart_service.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/delete_from_cart_service.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/show_cart_item_service.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/show_cart_price_service.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/show_cart_service.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/update_cart_item_service.dart';
import 'package:e_commerce_app/features/cart/data/models/add_to_cart_response_model.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:e_commerce_app/features/cart/data/models/delete_from_cart_response_model.dart';
import 'package:e_commerce_app/features/cart/data/models/show_cart_response_model.dart';
import 'package:e_commerce_app/features/cart/data/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl({
    required this.addToCartService,
    required this.deleteFromCartService,
    required this.showCartPriceService,
    required this.showCartService,
    required this.showCartItemService,
    required this.updateCartItemService,
  });

  final AddToCartService addToCartService;
  final DeleteFromCartService deleteFromCartService;
  final ShowCartPriceService showCartPriceService;
  final ShowCartService showCartService;
  final ShowCartItemService showCartItemService;
  final UpdateCartItemService updateCartItemService;

  @override
  Future<AddToCartResponseModel> addToCart(int productId) async {
    return await addToCartService.addToCart(productId: productId);
  }

  @override
  Future<DeleteFromCartResponseModel> deleteFromCart(int cartItemId) async {
    return await deleteFromCartService.deleteFromCart(cartItemId: cartItemId);
  }

  @override
  Future<String> showCartPrice() async {
    return await showCartPriceService.getPrice();
  }

  @override
  Future<ShowCartResponseModel> showCart() async {
    return await showCartService.showCart();
  }

  @override
  Future<CartItemModel> showCartItem(int cartItemId) async {
    return await showCartItemService.showCartItem(cartItemId: cartItemId);
  }

  @override
  Future<bool> updateCartItem(
      {required int cartId, required int newQuantity}) async {
    return await updateCartItemService.updateCartItem(
      cartId: cartId,
      newQuantity: newQuantity,
    );
  }
}
