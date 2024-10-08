import 'package:e_commerce_app/core/utils/app_assets/images/app_images.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomRoundedImageContainer extends StatelessWidget {
  final String imagePath;
  final double height;
  final double width;
  final double borderRadius;
  final BoxFit fit;
  final bool inAsset;

  const CustomRoundedImageContainer({
    super.key,
    required this.imagePath,
    this.inAsset = false,
    this.height = 140,
    this.width = double.infinity,
    this.borderRadius = 30,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: inAsset
            ? Image.asset(
                imagePath,
                height: height,
                width: width,
                fit: fit,
              )
            : Image.network(
                imagePath,
                height: height,
                width: width,
                fit: fit,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Image.asset(
                    AppImages.imagesNotDownloaded,
                    height: height,
                    width: width,
                    fit: fit,
                  );
                },
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: ThemeColors.primaryColor,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
