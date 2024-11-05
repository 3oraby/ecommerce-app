import 'package:e_commerce_app/core/widgets/custom_horizontal_product_item.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/cart/data/models/show_cart_response_model.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/checkout_action_button.dart';
import 'package:e_commerce_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBodyLoaded extends StatelessWidget {
  const CartBodyLoaded({
    super.key,
    required this.showCartResponseModel,
    required this.cartPrice,
    required this.totalQuantity,
    required this.onProductTap,
  });

  final ShowCartResponseModel showCartResponseModel;
  final String cartPrice;
  final int totalQuantity;
  final void Function(int selectedProductIndex) onProductTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: showCartResponseModel.cartItems!.length,
              separatorBuilder: (context, index) => const VerticalGap(36),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => onProductTap(index),
                child: CustomHorizontalProductItem(
                  cartItemModel: showCartResponseModel.cartItems![index],
                  onDeleteItemPressed: () async {
                    await BlocProvider.of<CartCubit>(context)
                        .deleteItemFromCart(
                      showCartResponseModel.cartItems![index].id,
                    );
                  },
                  onMoveToFavoritesItemPressed: () {
                    if (showCartResponseModel
                            .cartItems![index].product.isFavorite ==
                        0) {
                      BlocProvider.of<FavoritesCubit>(context).toggleFavorite(
                          productId: showCartResponseModel
                              .cartItems![index].product.id);
                    }

                    BlocProvider.of<CartCubit>(context).moveItemToFavorites(
                        showCartResponseModel.cartItems![index].id);
                  },
                ),
              ),
            ),
          ),
          const VerticalGap(36),
          CheckoutActionButton(
            totalQuantity: totalQuantity,
            cartItems: showCartResponseModel.cartItems!,
            cartPrice: cartPrice,
          ),
        ],
      ),
    );
  }
}
