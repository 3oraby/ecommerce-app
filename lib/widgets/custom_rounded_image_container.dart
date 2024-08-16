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
        image: DecorationImage(
          image: inAsset ? AssetImage(imagePath) : NetworkImage(imagePath),
          fit: fit,
        ),
      ),
    );
  }
}
