import 'package:e_commerce_app/features/favorites/presentation/widgets/favorites_empty_body.dart';
import 'package:e_commerce_app/features/favorites/presentation/widgets/favorites_loaded_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:e_commerce_app/features/favorites/presentation/cubit/favorites_states.dart';

class FavoritesBody extends StatelessWidget {
  const FavoritesBody({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavoritesCubit>().getFavorites();

    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FavoritesLoaded) {
          return FavoritesLoadedBody(
            getFavoritesResponseModel: state.favorites,
          );
        } else if (state is FavoritesError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(fontSize: 25, color: Colors.red),
            ),
          );
        } else if (state is FavoritesEmpty) {
          return const FavoritesEmptyBody();
        } else {
          return Container();
        }
      },
    );
  }
}
