import 'package:flutter/material.dart';

class FavoritesEmptyBody extends StatelessWidget {
  const FavoritesEmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No favorites yet.'),
    );
  }
}
