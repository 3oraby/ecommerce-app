import 'package:e_commerce_app/features/home/presentation/widgets/taps/category/category_tap_body.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/home_page_tab_bar.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/taps/home/home_tap_body.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        VerticalGap(16),
        HomePageTabBar(),
        VerticalGap(16),
        Expanded(
          child: TabBarView(
            children: [
              HomeTapBody(),
              CategoryTapBody(),
            ],
          ),
        ),
      ],
    );
  }
}
