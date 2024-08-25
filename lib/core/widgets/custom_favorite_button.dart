import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/favorites/presentation/cubit/favorites_cubit.dart';

class CustomFavoriteButton extends StatefulWidget {
  final ProductModel productModel;
  final bool isFavoritePage;
  final double borderWidth;

  const CustomFavoriteButton({
    super.key,
    required this.productModel,
    this.isFavoritePage = false,
    this.borderWidth = 0.5,
  });

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
          width: widget.borderWidth,
        ),
      ),
      child: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? ThemeColors.secondaryColor : Colors.grey,
        ),
        iconSize: 30,
        onPressed: () async {
          await context.read<FavoritesCubit>().toggleFavorite(
                productId: widget.productModel.id,
                shouldRefresh: widget.isFavoritePage,
              );

          if (mounted) {
            setState(() {
              isFavorite = !isFavorite;
              widget.productModel.isFavorite = isFavorite ? 1 : 0;
            });
          }
        },
      ),
    );
  }
}
