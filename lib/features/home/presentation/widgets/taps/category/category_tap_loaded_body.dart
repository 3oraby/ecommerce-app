import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/models/category_model.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_rounded_image_container.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          horizontal: LocalConstants.kHorizontalPadding),
      child: ListView.separated(
        itemCount: categories.length,
        separatorBuilder: (context, index) => const VerticalGap(36),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => onCategoryTap(index),
          child: Container(
            decoration: BoxDecoration(
              color: ThemeColors.backgroundBodiesColor,
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                const HorizontalGap(5),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Text(
                    categories[index].name,
                    style: GoogleFonts.aDLaMDisplay(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                const HorizontalGap(5),
                CustomRoundedImageContainer(
                  imagePath:
                      "${ApiConstants.baseUrl}${ApiConstants.getPhotoEndPoint}${categories[index].photo}",
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
