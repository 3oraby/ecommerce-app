import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class ProductAmountSelector extends StatelessWidget {
  final int productAmount;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final double width;
  final double height;
  final Color color;
  final Color itemsColor;
  final double borderRadius;
  final double textSize;
  final double iconSize;

  const ProductAmountSelector({
    super.key,
    required this.productAmount,
    required this.onAdd,
    required this.onRemove,
    this.width = 150.0,
    this.height = 50.0,
    this.color = ThemeColors.primaryColor,
    this.itemsColor = Colors.white,
    this.borderRadius = 10,
    this.textSize = 24,
    this.iconSize = 26,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onRemove,
            icon: Icon(
              Icons.remove_circle,
              color: itemsColor,
              size: iconSize,
            ),
          ),
          Text(
            "$productAmount",
            style: TextStyle(
              color: itemsColor,
              fontSize: textSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: onAdd,
            icon: Icon(
              Icons.add_circle,
              color: itemsColor,
              size: iconSize,
            ),
          ),
        ],
      ),
    );
  }
}
