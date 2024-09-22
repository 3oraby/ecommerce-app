import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/widgets/custom_horizontal_product_shimmer_loading.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyOrdersBodyShimmerLoading extends StatelessWidget {
  const MyOrdersBodyShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: ListView.separated(
        itemCount: 5,
        separatorBuilder: (context, index) => const VerticalGap(48),
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomHorizontalProductShimmerLoading(),
              const VerticalGap(36),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 25,
                    width: screenWidth * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        LocalConstants.kBorderRadius,
                      ),
                    ),
                  ),
                  Container(
                    height: 25,
                    width: screenWidth * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        LocalConstants.kBorderRadius,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
