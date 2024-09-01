import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/controllers/app_page_manager.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class HomePageLoaded extends StatefulWidget {
  const HomePageLoaded({
    super.key,
    required this.userModel,
  });
  final UserModel userModel;
  @override
  State<HomePageLoaded> createState() => _HomePageLoadedState();
}

class _HomePageLoadedState extends State<HomePageLoaded> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppPageManager(userModel: widget.userModel)
            .getAppBar(HomePage.currentIndexNotifier.value, context),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: HomePage.currentIndexNotifier.value,
          type: BottomNavigationBarType.fixed,
          iconSize: 40,
          selectedItemColor: ThemeColors.primaryColor,
          onTap: (int index) {
            if (mounted) {
              setState(() {
                HomePage.currentIndexNotifier.value = index;
              });
            }
          },
          items: [
            for (int i = 0;
                i < LocalConstants.bottomNavigationBarData.length;
                i++)
              BottomNavigationBarItem(
                icon: LocalConstants.bottomNavigationBarData[i].icon,
                label: LocalConstants.bottomNavigationBarData[i].label,
              ),
          ],
        ),
        body: AppPageManager(userModel: widget.userModel)
            .getPage(HomePage.currentIndexNotifier.value),
      ),
    );
  }
}
