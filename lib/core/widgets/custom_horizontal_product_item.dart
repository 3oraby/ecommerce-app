import 'package:e_commerce_app/core/helpers/functions/get_photo_url.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_rounded_image_container.dart';
import 'package:e_commerce_app/core/widgets/custom_show_product_quantity.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/item_options_operations_section.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
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
    this.imageHeight = 150,
    this.imageWidth = 150,
    this.borderWidth = 0.2,
    this.isLastRowEnabled = true,
    this.onDeleteItemPressed,
    this.onMoveToFavoritesItemPressed,
  });

  final CartItemModel cartItemModel;
  final Color backgroundColor;
  final double borderRadius;
  final double borderWidth;
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
  @override
  void initState() {
    super.initState();
    productAmount = widget.cartItemModel.quantity;
  }

  @override
  Widget build(BuildContext context) {
    ProductModel productModel = widget.cartItemModel.product;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 16,
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
          Row(
            children: [
              HorizontalItemPhotoSection(
                  widget: widget, productModel: productModel),
              const HorizontalGap(8),
              HorizontalItemInformationSection(productModel: productModel),
            ],
          ),
          Visibility(
            visible: widget.isLastRowEnabled,
            child: ItemOptionsOperationsSection(
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
          ),
        ],
      ),
    );
  }
}

class HorizontalItemPhotoSection extends StatelessWidget {
  const HorizontalItemPhotoSection({
    super.key,
    required this.widget,
    required this.productModel,
  });

  final CustomHorizontalProductItem widget;
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class HorizontalItemInformationSection extends StatelessWidget {
  const HorizontalItemInformationSection({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productModel.description,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
          ),
          const VerticalGap(16),
          Text(
            "EGP ${productModel.price}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ThemeColors.mainLabelsColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const VerticalGap(6),
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
    );
  }
}
