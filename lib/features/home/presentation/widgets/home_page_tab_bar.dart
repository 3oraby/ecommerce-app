import 'package:e_commerce_app/features/home/constants/home_page_constants.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class HomePageTabBar extends StatelessWidget {
  const HomePageTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: ThemeColors.primaryColor,
      indicatorWeight: 3.0,
      labelColor: HomePageConstants.selectedColor,
      unselectedLabelColor: HomePageConstants.unSelectedColor,
      labelStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      dividerColor: Colors.white,
      tabs: [
        for (int i = 0; i < HomePageConstants.homePageTabs.length; i++)
          Tab(
            text: HomePageConstants.homePageTabs[i],
          ),
      ],
    );
  }
}
