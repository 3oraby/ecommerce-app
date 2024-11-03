import 'package:e_commerce_app/core/helpers/functions/get_photo_url.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_rounded_image_container.dart';
import 'package:e_commerce_app/core/widgets/custom_show_product_quantity.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/item_options_operations_section.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/cart/data/models/cart_item_model.dart';

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
    this.onMoveToFavoritesItemPressed,
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
  final VoidCallback? onMoveToFavoritesItemPressed;

  @override
  State<CustomHorizontalProductItem> createState() =>
      _CustomHorizontalProductItemState();
}

class _CustomHorizontalProductItemState
    extends State<CustomHorizontalProductItem> {
  late int productAmount = widget.cartItemModel.quantity;
  late double height = widget.height;
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
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Free Delivery",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
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
          ItemOptionsOperationsSection(
            isLastRowEnabled: widget.isLastRowEnabled,
            cartItemId: widget.cartItemModel.id,
            productAmount: productAmount,
            onDeleteItemPressed: widget.onDeleteItemPressed,
            onMoveToFavoritesItemPressed: widget.onMoveToFavoritesItemPressed,
            onQuantitySelected: (value) {
              BlocProvider.of<CartCubit>(context).updateCartItem(
                cartId: widget.cartItemModel.id,
                quantity: value,
              );
              setState(() {
                widget.cartItemModel.quantity = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
