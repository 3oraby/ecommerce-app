import 'package:e_commerce_app/features/cart/data/models/add_to_cart_response_model.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:e_commerce_app/features/cart/data/models/delete_from_cart_response_model.dart';
import 'package:e_commerce_app/features/cart/data/models/show_cart_response_model.dart';

abstract class CartRepository {
  Future<ShowCartResponseModel> showCart();

  Future<AddToCartResponseModel> addToCart(int productId);

  Future<DeleteFromCartResponseModel> deleteFromCart(int cartItemId);

  Future<String> showCartPrice();

  Future<bool> updateCartItem({
    int? cartId,
    int? productId,
    required int newQuantity,
  });

  Future<bool> updateCartItemInProductDetails({
    required int productId,
    required int newQuantity,
  });

  Future<CartItemModel> showCartItem(int cartItemId);

  Future<bool> checkProductInCart(int productId);
}
