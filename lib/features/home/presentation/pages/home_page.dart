import 'package:e_commerce_app/features/home/presentation/widgets/home_page_loaded.dart';
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

  @override
  void initState() {
    super.initState();
    // Add a listener to rebuild the UI whenever currentIndex changes
    HomePage.currentIndexNotifier.addListener(handleIndexChange);
    BlocProvider.of<UserCubit>(context).getUser();
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
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is GetUserLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is GetUserErrorState) {
          return Scaffold(
            body: Center(
              child: Text(state.message),
            ),
          );
        } else if (state is GetUserLoadedState) {
          return HomePageLoaded(userModel: state.getUserResponseModel.user!);
        } else {
          return const Scaffold(
            body: Center(
              child: Text("can not get the user from back-end"),
            ),
          );
        }
      },
    );
  }
}
