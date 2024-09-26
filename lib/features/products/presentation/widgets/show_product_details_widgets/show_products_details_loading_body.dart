import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShowProductsDetailsLoadingBody extends StatelessWidget {
  const ShowProductsDetailsLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width -
        (2 * LocalConstants.kHorizontalPadding);

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: ListView(
                children: [
                  const VerticalGap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 30,
                          color: Colors.grey[300],
                          width: MediaQuery.of(context).size.width * 0.4,
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 30,
                          color: Colors.grey[300],
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                      ),
                    ],
                  ),
                  const VerticalGap(16),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 20,
                      width: 120,
                      color: Colors.grey[300],
                    ),
                  ),
                  const VerticalGap(16),
                  // Description placeholder
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      children: List.generate(6, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Container(
                            height: 20,
                            width: double.infinity,
                            color: Colors.grey[300],
                          ),
                        );
                      }),
                    ),
                  ),
                  const VerticalGap(24),
                  // Image placeholder
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.75,
                      color: Colors.grey[300],
                    ),
                  ),
                  const VerticalGap(36),
                  // Price section placeholder
                  Row(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 22,
                          width: 40,
                          color: Colors.grey[300],
                        ),
                      ),
                      const HorizontalGap(8),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 22,
                          width: 100,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                  const VerticalGap(16),
                  // Selling out fast placeholder
                  Row(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 30,
                          width: 30,
                          color: Colors.grey[300],
                        ),
                      ),
                      const HorizontalGap(4),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 18,
                          width: 150,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                  const VerticalGap(48),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: LocalConstants.kHorizontalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 50,
                    width: screenWidth * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius:
                          BorderRadius.circular(LocalConstants.kBorderRadius),
                    ),
                  ),
                ),
                const HorizontalGap(16),
                Expanded(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 50,
                      width: screenWidth * 0.6,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius:
                            BorderRadius.circular(LocalConstants.kBorderRadius),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const VerticalGap(16),
        ],
      ),
    );
  }
}
