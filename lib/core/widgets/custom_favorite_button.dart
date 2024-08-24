import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/favorites/data/data_sources/add_or_delete_favorite_service.dart';
import 'package:flutter/material.dart';

class CustomFavoriteButton extends StatefulWidget {
  const CustomFavoriteButton({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;
  @override
  State<CustomFavoriteButton> createState() => _CustomFavoriteButtonState();
}

class _CustomFavoriteButtonState extends State<CustomFavoriteButton> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.productModel.isFavorite == 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isFavorite ? ThemeColors.secondaryColor : Colors.grey,
          width: 0.5,
        ),
      ),
      child: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? ThemeColors.secondaryColor : Colors.grey,
        ),
        iconSize: 30,
        onPressed: () async {
          await AddOrDeleteFavoritesService.addOrDeleteFavorites(
            productId: widget.productModel.id,
          );
          setState(() {
            isFavorite = !isFavorite;
            widget.productModel.isFavorite = isFavorite ? 1 : 0;
          });
        },
      ),
    );
  }
}
