import 'package:e_commerce_app/core/helpers/functions/show_error_with_internet_dialog.dart';
import 'package:e_commerce_app/core/helpers/functions/show_not_signed_in_dialog.dart';
import 'package:e_commerce_app/core/helpers/functions/show_snack_bar.dart';
import 'package:e_commerce_app/features/favorites/presentation/cubit/favorites_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:lottie/lottie.dart';

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
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    isFavorite = widget.productModel.isFavorite == 1;
  }

  @override
  Widget build(BuildContext context) {
    final FavoritesCubit favoritesCubit =
        BlocProvider.of<FavoritesCubit>(context);
    return BlocListener<FavoritesCubit, FavoritesState>(
      listener: (context, favoritesState) {
        if (favoritesState is ToggleFavoritesLoadingState) {
          if (favoritesCubit.getProductWillMoveToFavorites
              .contains(widget.productModel.id)) {
            setState(() {
              isLoading = true;
            });
          }
        } else if (favoritesState is ToggleFavoritesNoInternetConnectionState) {
          if (favoritesState.productId == widget.productModel.id) {
            showErrorWithInternetDialog(context);
          }
        } else if (favoritesState is ToggleFavoritesErrorState) {
          setState(() {
            isLoading = false;
          });
          showSnackBar(context, favoritesState.message);
        } else if (favoritesState is ToggleFavoritesLoadedState) {
          setState(() {
            isLoading = false;
          });
        } else if (favoritesState is ToggleFavoritesUnAuthState) {
          setState(() {
            isLoading = false;
          });
          if (favoritesState.productId == widget.productModel.id) {
            showNotSignedInDialog(context);
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isFavorite ? ThemeColors.secondaryColor : Colors.grey,
            width: widget.borderWidth,
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Lottie.asset("assets/animations/button_loading.json"),
              )
            : IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? ThemeColors.secondaryColor : Colors.grey,
                ),
                iconSize: 30,
                onPressed: () async {
                  final success = await BlocProvider.of<FavoritesCubit>(context)
                      .toggleFavorite(
                    productId: widget.productModel.id,
                    shouldRefresh: widget.isFavoritePage,
                  );

                  if (mounted) {
                    if (success) {
                      setState(() {
                        isFavorite = !isFavorite;
                        widget.productModel.isFavorite = isFavorite ? 1 : 0;
                      });
                      showSnackBar(
                          context,
                          isFavorite
                              ? 'Added to favorites'
                              : 'Removed from favorites',
                          backgroundColor: isFavorite
                              ? ThemeColors.successfullyDoneColor
                              : ThemeColors.mainLabelsColor);
                    }
                  }
                },
              ),
      ),
    );
  }
}
