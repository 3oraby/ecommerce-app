import 'package:e_commerce_app/features/cart/data/data_sources/add_to_cart_service.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/check_product_in_cart_service.dart';
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
    required this.checkProductInCartService,
  });

  final AddToCartService addToCartService;
  final DeleteFromCartService deleteFromCartService;
  final ShowCartPriceService showCartPriceService;
  final ShowCartService showCartService;
  final ShowCartItemService showCartItemService;
  final UpdateCartItemService updateCartItemService;
  final CheckProductInCartService checkProductInCartService;

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
      {int ?cartId, required int newQuantity,int? productId}) async {
    return await updateCartItemService.updateCartItem(
      cartId: cartId,
      productId: productId,
      newQuantity: newQuantity,
    );
  }

  @override
  Future<bool> updateCartItemInProductDetails(
      {required int productId, required int newQuantity}) async {
    return await updateCartItemService.updateCartItem(
      productId: productId,
      newQuantity: newQuantity,
    );
  }

  @override
  Future<bool> checkProductInCart(int productId) async {
    return await checkProductInCartService.checkProductInCart(
        productId: productId);
  }
}
