import 'package:e_commerce_app/features/cart/data/models/add_to_cart_response_model.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:e_commerce_app/features/cart/data/models/delete_from_cart_response_model.dart';
import 'package:e_commerce_app/features/cart/data/models/show_cart_response_model.dart';

abstract class CartRepository {
  Future<ShowCartResponseModel> showCart();

  Future<AddToCartResponseModel> addToCart(int productId);

  Future<DeleteFromCartResponseModel> deleteFromCart(int cartItemId);

  Future<String> getPrice();

  Future<bool> updateCartItem({
    required int cartId,
    required int newQuantity,
  });

  Future<CartItemModel> showCartItem(int cartItemId);
}
