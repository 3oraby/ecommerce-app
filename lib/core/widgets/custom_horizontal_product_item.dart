import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/get_photo_url.dart';
import 'package:e_commerce_app/core/helpers/functions/show_error_with_internet_dialog.dart';
import 'package:e_commerce_app/core/helpers/functions/show_snack_bar.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_rounded_image_container.dart';
import 'package:e_commerce_app/core/widgets/custom_show_product_quantity.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/quantity_selector.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_state.dart';
import 'package:e_commerce_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class CustomHorizontalProductItem extends StatefulWidget {
  const CustomHorizontalProductItem({
    super.key,
    required this.cartItemModel,
    this.backgroundColor = Colors.white,
    this.borderRadius = 10,
    this.height = 300,
    this.imageHeight = 150,
    this.imageWidth = 150,
    this.borderWidth = 0.2,
    this.width = double.infinity,
    this.isLastRowEnabled = true,
    this.onDeleteItemPressed,
  });

  final CartItemModel cartItemModel;
  final Color backgroundColor;
  final double borderRadius;
  final double borderWidth;
  final double height;
  final double width;
  final double imageHeight;
  final double imageWidth;
  final bool isLastRowEnabled;
  final VoidCallback? onDeleteItemPressed;

  @override
  State<CustomHorizontalProductItem> createState() =>
      _CustomHorizontalProductItemState();
}

class _CustomHorizontalProductItemState
    extends State<CustomHorizontalProductItem> {
  late int productAmount = widget.cartItemModel.quantity;
  late double height = widget.height;
  bool showQuantity = false;

  @override
  void initState() {
    super.initState();
    productAmount = widget.cartItemModel.quantity;
    if (widget.isLastRowEnabled) {
      height = widget.height;
    } else {
      height = widget.height - 80;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width -
        (2 * LocalConstants.kHorizontalPadding);

    ProductModel productModel = widget.cartItemModel.product;
    return Container(
      height: height,
      width: widget.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        border: Border.all(
          color: (widget.borderWidth != 0) ? Colors.grey : Colors.white,
          width: widget.borderWidth,
        ),
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: [
          if (widget.borderWidth != 0)
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomShowProductQuantity(
                      isShow: !widget.isLastRowEnabled,
                      quantity: widget.cartItemModel.quantity,
                    ),
                    CustomRoundedImageContainer(
                      imagePath: getPhotoUrl(productModel.photo),
                      height: widget.imageHeight,
                      width: widget.imageWidth,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                const HorizontalGap(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(flex: 3),
                      Text(
                        productModel.description,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                      const Spacer(flex: 3),
                      Text(
                        "EGP ${productModel.price}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: ThemeColors.mainLabelsColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Visibility(
                        visible: productModel.price > 500,
                        maintainInteractivity: true,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: const Row(
                          children: [
                            Icon(
                              Icons.delivery_dining,
                              color: ThemeColors.primaryColor,
                            ),
                            HorizontalGap(10),
                            Text(
                              "Free Delivery",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: widget.isLastRowEnabled,
            child: Column(
              children: [
                const VerticalGap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showQuantity = !showQuantity;
                          if (showQuantity) {
                            height += 80;
                          } else {
                            height -= 80;
                          }
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "$productAmount",
                              style: TextStyles.aDLaMDisplayBlackBold20,
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              size: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                    CustomDeleteButton(
                      onDeleteItemPressed: widget.onDeleteItemPressed,
                    ),
                    CustomTriggerButton(
                      onPressed: () {
                        if (productModel.isFavorite == 0) {
                          BlocProvider.of<FavoritesCubit>(context)
                              .toggleFavorite(productId: productModel.id);
                        }

                        BlocProvider.of<CartCubit>(context)
                            .deleteItemFromCart(widget.cartItemModel.id);
                      },
                      buttonWidth: screenWidth * 0.5,
                      buttonHeight: 40,
                      borderRadius: 10,
                      description: "move to favorites",
                      descriptionSize: 18,
                      icon: Icons.favorite_outline_outlined,
                      iconSize: 28,
                    ),
                  ],
                ),
                Visibility(
                  visible: showQuantity,
                  child: QuantitySelector(
                    productAmount: productAmount,
                    onCancel: () {
                      setState(() {
                        showQuantity = false;
                        height = widget.height;
                      });
                    },
                    onQuantitySelected: (value) async {
                      setState(() {
                        productAmount = value;
                        showQuantity = false;
                        height = widget.height;
                      });
                      BlocProvider.of<CartCubit>(context).updateCartItem(
                        cartId: widget.cartItemModel.id,
                        quantity: value,
                      );
                      // update the value of the product quantity to pass the model to checkout page
                      widget.cartItemModel.quantity = value;
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDeleteButton extends StatefulWidget {
  const CustomDeleteButton({
    super.key,
    this.onDeleteItemPressed,
  });
  final VoidCallback? onDeleteItemPressed;

  @override
  State<CustomDeleteButton> createState() => _CustomDeleteButtonState();
}

class _CustomDeleteButtonState extends State<CustomDeleteButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width -
        (2 * LocalConstants.kHorizontalPadding);
    return BlocListener<CartCubit, CartState>(
      listenWhen: (previous, current) {
        return current is DeleteFromCartLoadingState ||
            current is DeleteFromCartErrorState ||
            current is DeleteCartNoNetworkErrorState;
      },
      listener: (context, state) {
        if (state is DeleteFromCartLoadingState) {
          setState(() {
            isLoading = true;
          });
        } else if (state is DeleteCartNoNetworkErrorState) {
          setState(() {
            isLoading = false;
          });
          showErrorWithInternetDialog(context);
        } else if (state is DeleteFromCartErrorState) {
          setState(() {
            isLoading = false;
          });
          showSnackBar(context, state.message);
        }
      },
      child: CustomTriggerButton(
        onPressed: widget.onDeleteItemPressed,
        buttonWidth: screenWidth * 0.2,
        buttonHeight: 40,
        icon: Icons.delete,
        iconColor: const Color.fromARGB(255, 129, 33, 24),
        backgroundColor: Colors.white,
        borderWidth: 1,
        borderColor: Colors.grey,
        iconSize: 28,
        child: isLoading
            ? Lottie.asset("assets/animations/button_loading.json")
            : null,
      ),
    );
  }
}
