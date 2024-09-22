import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/widgets/custom_main_product_shimmer_loading.dart';
import 'package:flutter/material.dart';

class GridViewItemsLoading extends StatelessWidget {
  const GridViewItemsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LocalConstants.kHorizontalPadding,vertical: 48),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 48,
          childAspectRatio: 0.5,
        ),
        itemCount: 15,
        itemBuilder: (context, index) => Transform.translate(
          offset: Offset(0, index.isOdd ? 36 : 0),
          child: const CustomMainProductShimmerLoading(),
        ),
      ),
    );
  }
}
