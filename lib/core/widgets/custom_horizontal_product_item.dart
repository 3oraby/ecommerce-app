import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/widgets/custom_rounded_image_container.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/product_amount_selector.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHorizontalProductItem extends StatefulWidget {
  const CustomHorizontalProductItem({
    super.key,
    required this.productModel,
    required this.quantity,
    this.backgroundColor = Colors.white,
    this.borderRadius = 30,
    this.height = 220,
    this.width = double.infinity,
  });

  final ProductModel productModel;
  final int quantity;
  final Color backgroundColor;
  final double borderRadius;
  final double height;
  final double width;

  @override
  State<CustomHorizontalProductItem> createState() =>
      _CustomHorizontalProductItemState();
}

class _CustomHorizontalProductItemState
    extends State<CustomHorizontalProductItem> {
  late int productAmount;
  @override
  void initState() {
    super.initState();
    productAmount = widget.quantity;
  }

  void increaseAmount() {
    setState(() {
      if (productAmount < 20) {
        productAmount += 1;
      }
    });
  }

  void decreaseAmount() {
    setState(() {
      if (productAmount > 0) {
        productAmount -= 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: [
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
                CustomRoundedImageContainer(
                  imagePath:
                      "${ApiConstants.baseUrl}${ApiConstants.getPhotoEndPoint}${widget.productModel.photo}",
                  height: 150,
                  width: 150,
                  fit: BoxFit.contain,
                ),
                const HorizontalGap(26),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const VerticalGap(24),
                      Expanded(
                        child: Text(
                          widget.productModel.name,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aDLaMDisplay(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      ),
                      Text(
                        "EGP ${widget.productModel.price}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.aDLaMDisplay(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const VerticalGap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProductAmountSelector(
                productAmount: productAmount,
                onAdd: increaseAmount,
                onRemove: decreaseAmount,
                height: 40,
              ),
              CustomTriggerButton(
                onPressed: () {},
                buttonWidth: 220,
                buttonHeight: 40,
                borderRadius: 10,
                description: "move to favorites",
                descriptionSize: 18,
                icon: Icons.favorite_outline_outlined,
                iconSize: 28,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
