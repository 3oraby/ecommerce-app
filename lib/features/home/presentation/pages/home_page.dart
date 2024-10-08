import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/controllers/app_page_manager.dart';
import 'package:e_commerce_app/core/helpers/functions/is_user_signed_in.dart';
import 'package:e_commerce_app/core/helpers/functions/show_not_signed_in_dialog.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const id = "homePage";
  // Create a ValueNotifier that can be accessed globally
  static final ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(0);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double kTabBarHeight = 48.0;

  @override
  void initState() {
    super.initState();
    // Add a listener to rebuild the UI whenever currentIndex changes
    HomePage.currentIndexNotifier.addListener(handleIndexChange);
  }

  @override
  void dispose() {
    super.dispose();
    HomePage.currentIndexNotifier.removeListener(
      () {},
    );
  }

  void handleIndexChange() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ThemeColors.backgroundBodiesColor,
        appBar: AppPageManager()
            .getAppBar(HomePage.currentIndexNotifier.value, context),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: HomePage.currentIndexNotifier.value,
          type: BottomNavigationBarType.fixed,
          iconSize: 40,
          selectedItemColor: ThemeColors.primaryColor,
          onTap: (int index) {
            if (mounted) {
              if (index > 0 && !isUserSignedIn()) {
                showNotSignedInDialog(context);
              } else {
                setState(() {
                  HomePage.currentIndexNotifier.value = index;
                });
              }
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
        body: AppPageManager().getPage(HomePage.currentIndexNotifier.value),
      ),
    );
  }
}
