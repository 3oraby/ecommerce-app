import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomFavoriteButton extends StatefulWidget {
  const CustomFavoriteButton({super.key});

  @override
  State<CustomFavoriteButton> createState() => _CustomFavoriteButtonState();
}

class _CustomFavoriteButtonState extends State<CustomFavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Background color inside the border
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isFavorite ? ThemeColors.secondaryColor : Colors.grey, // Border color
          width: 1, // Border width
        ),
      ),
      child: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? ThemeColors.secondaryColor : Colors.grey,
        ),
        iconSize: 30,
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        },
      ),
    );
  }
}
