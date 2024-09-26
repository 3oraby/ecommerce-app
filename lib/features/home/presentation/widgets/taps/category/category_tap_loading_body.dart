import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class CategoryTapLoadingBody extends StatelessWidget {
  const CategoryTapLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        itemCount: 5, 
        separatorBuilder: (context, index) => const SizedBox(height: 36),
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                const SizedBox(width: 5),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 25,
                  color: Colors.grey[300], 
                ),
                const SizedBox(width: 5),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 100,
                  color: Colors.grey[300], 
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
