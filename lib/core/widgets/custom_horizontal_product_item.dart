import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_rounded_image_container.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/quantity_selector.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:flutter/material.dart';

class CustomHorizontalProductItem extends StatefulWidget {
  const CustomHorizontalProductItem({
    super.key,
    required this.productModel,
    required this.quantity,
    this.backgroundColor = Colors.white,
    this.borderRadius = 30,
    this.height = 300,
    this.imageHeight = 150,
    this.imageWidth = 150,
    this.width = double.infinity,
  });

  final ProductModel productModel;
  final int quantity;
  final Color backgroundColor;
  final double borderRadius;
  final double height;
  final double width;
  final double imageHeight;
  final double imageWidth;

  @override
  State<CustomHorizontalProductItem> createState() =>
      _CustomHorizontalProductItemState();
}

class _CustomHorizontalProductItemState
    extends State<CustomHorizontalProductItem> {
  late int productAmount = widget.quantity;
  late double height = widget.height;
  bool showQuantity = false;

  @override
  void initState() {
    super.initState();
    productAmount = widget.quantity;
    height = widget.height;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
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
                  height: widget.imageHeight,
                  width: widget.imageWidth,
                  fit: BoxFit.contain,
                ),
                const HorizontalGap(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(flex: 3),
                      Text(
                        widget.productModel.description,
                        textAlign: TextAlign.start,
                        style: TextStyles.aDLaMDisplayBlackBold20,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                      const Spacer(flex: 3),
                      Text(
                        "EGP ${widget.productModel.price}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Visibility(
                        visible: widget.productModel.price > 500,
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
          const VerticalGap(16),
          Column(
            children: [
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
                  onQuantitySelected: (value) {
                    setState(() {
                      productAmount = value;
                      showQuantity = false;
                      height = widget.height;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
