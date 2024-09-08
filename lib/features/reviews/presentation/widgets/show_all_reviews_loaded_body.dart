import 'package:e_commerce_app/core/helpers/functions/get_photo_url.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/show_all_reviews_widget.dart';
import 'package:e_commerce_app/core/widgets/show_product_average_rating.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:e_commerce_app/features/reviews/data/models/product_review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowAllReviewsLoadedBody extends StatelessWidget {
  const ShowAllReviewsLoadedBody({
    super.key,
    required this.productReviews,
    required this.averageRating,
  });

  final List<ProductReviewModel> productReviews;
  final String averageRating;

  @override
  Widget build(BuildContext context) {
    final ProductCatalogCubit productCatalogCubit =
        BlocProvider.of<ProductCatalogCubit>(context);
    final ProductModel product = productCatalogCubit.getSelectedProduct!;

    return ListView(
      children: [
        ShowProductDetails(product: product),
        const VerticalGap(4),
        ShowAverageRating(averageRating: averageRating),
        const VerticalGap(24),
        ShowAllReviews(productReviews: productReviews),
        const VerticalGap(24),
      ],
    );
  }
}

EdgeInsets contentPadding() {
  return const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );
}

class ShowProductDetails extends StatelessWidget {
  const ShowProductDetails({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.white,
      padding: contentPadding(),
      child: Row(
        children: [
          Image.network(
            getPhotoUrl(product.photo),
            width: MediaQuery.of(context).size.width * 0.2,
            height: screenHeight * 0.1,
            fit: BoxFit.contain,
          ),
          const HorizontalGap(16),
          Expanded(
            child: Text(
              product.description,
              style: TextStyles.aDLaMDisplayBlackBold18,
            ),
          ),
        ],
      ),
    );
  }
}


