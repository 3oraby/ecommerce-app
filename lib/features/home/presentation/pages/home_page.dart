import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/controllers/app_page_manager.dart';
import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_screen_arguments.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const id = "homePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double kTabBarHeight = 48.0;

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    //! save this data in shared preferences not pass it by pages
    AuthScreenArguments authScreenArguments =
        ModalRoute.of(context)!.settings.arguments as AuthScreenArguments;
    UserModel userModel = authScreenArguments.userModel;
    final String accessToken = authScreenArguments.accessToken;

    SharedPreferencesSingleton.setString("accessToken", accessToken);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppPageManager(userModel: userModel)
            .getAppBar(currentIndex, context),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          iconSize: 40,
          selectedItemColor: ThemeColors.primaryColor,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
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
        body: AppPageManager(userModel: userModel).getPage(currentIndex),
      ),
    );
  }
}
