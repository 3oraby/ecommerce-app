import 'package:e_commerce_app/features/home/presentation/widgets/taps/home/home_tap_loaded_body.dart';
import 'package:e_commerce_app/features/products/presentation/cubit/product_catalog_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTapBody extends StatefulWidget {
  const HomeTapBody({super.key});

  @override
  State<HomeTapBody> createState() => _HomeTapBodyState();
}

class _HomeTapBodyState extends State<HomeTapBody> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductCatalogCubit>(context).getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCatalogCubit, ProductCatalogState>(
      builder: (context, state) {
        if (state is GetHomeDataLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is GetHomeDataErrorState) {
          return Scaffold(
            body: Center(
              child: Text(state.message),
            ),
          );
        } else if (state is GetHomeDataLoadedState) {
          return HomeTapLoadedBody(
            pageController: pageController,
            homeDetailsResponseModel: state.getHomeDetailsResponseModel,
          );
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
