import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/widgets/custom_rounded_image_container.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
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
    this.height = 200,
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
                const HorizontalGap(16),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTriggerButton(
                buttonWidth: 120,
                buttonHeight: 40,
                borderWidth: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (productAmount > 0) {
                            productAmount -= 1;
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.remove_circle,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                    Text(
                      "$productAmount",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (productAmount < 20) {
                            productAmount += 1;
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.add_circle,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ],
                ),
              ),
              CustomTriggerButton(
                onPressed: () {},
                borderWidth: 0,
                buttonWidth: 200,
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
