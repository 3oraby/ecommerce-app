import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/get_photo_url.dart';
import 'package:e_commerce_app/core/models/category_model.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_rounded_image_container.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:flutter/material.dart';

class CategoryTapLoadedBody extends StatelessWidget {
  const CategoryTapLoadedBody({
    super.key,
    required this.categories,
    required this.onCategoryTap,
  });

  final List<CategoryModel> categories;
  final void Function(int index) onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: LocalConstants.kHorizontalPadding,
        vertical: 16,
      ),
      child: ListView.separated(
        itemCount: categories.length,
        separatorBuilder: (context, index) => const VerticalGap(36),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => onCategoryTap(index),
          child: Container(
            decoration: BoxDecoration(
              color: ThemeColors.backgroundBodiesColor,
              border: Border.all(
                color: ThemeColors.mainLabelsColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: CustomRoundedImageContainer(
              imagePath: getPhotoUrl(categories[index].photo),
              borderRadius: 10,
              height: MediaQuery.of(context).size.height * 0.15,
            ),
          ),
        ),
      ),
    );
  }
}
