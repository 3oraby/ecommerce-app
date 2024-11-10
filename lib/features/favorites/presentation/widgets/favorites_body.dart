import 'package:e_commerce_app/core/widgets/custom_empty_body_widget.dart';
import 'package:e_commerce_app/core/widgets/custom_no_internet_connection_body.dart';
import 'package:e_commerce_app/core/widgets/grid_view_items_loading.dart';
import 'package:e_commerce_app/features/favorites/presentation/widgets/favorites_loaded_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:e_commerce_app/features/favorites/presentation/cubit/favorites_states.dart';

class FavoritesBody extends StatelessWidget {
  const FavoritesBody({super.key});
  static const String id = "kFavoritesBody";

  @override
  Widget build(BuildContext context) {
    final FavoritesCubit favoritesCubit =
        BlocProvider.of<FavoritesCubit>(context);

    favoritesCubit.getFavorites();

    return BlocBuilder<FavoritesCubit, FavoritesState>(
      buildWhen: (previous, current) {
        return current is FavoritesLoading ||
            current is FavoritesLoaded ||
            current is FavoritesError ||
            current is FavoritesEmpty ||
            current is FavoritesNoInternetConnectionState;
      },
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return const GridViewItemsLoading();
        } else if (state is FavoritesLoaded) {
          return FavoritesLoadedBody(
            getFavoritesResponseModel: state.favorites,
          );
        } else if (state is FavoritesError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(fontSize: 25),
            ),
          );
        } else if (state is FavoritesEmpty) {
          return const CustomEmptyBodyWidget(
            mainLabel: "No Favorites Yet!",
            subLabel:
                "Start adding your favorite items by tapping the heart icon.",
            buttonDescription: 'Explore Products',
          );
        } else if (state is FavoritesNoInternetConnectionState) {
          return CustomNoInternetConnectionBody(
            onTryAgainPressed: () {
              favoritesCubit.getFavorites();
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
