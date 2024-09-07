import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/controllers/app_page_manager.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/user/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late UserModel userModel;
  @override
  void initState() {
    super.initState();
    // Add a listener to rebuild the UI whenever currentIndex changes
    HomePage.currentIndexNotifier.addListener(handleIndexChange);
    final userCubit = BlocProvider.of<UserCubit>(context);
    userModel = userCubit.getUserModel!;
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
        appBar: AppPageManager(userModel: userModel)
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
        body: AppPageManager(userModel: userModel)
            .getPage(HomePage.currentIndexNotifier.value),
      ),
    );
  }
}
