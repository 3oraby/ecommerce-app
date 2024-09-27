import 'dart:developer';

import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_no_internet_connection_body.dart';
import 'package:e_commerce_app/features/orders/data/models/order_items_model.dart';
import 'package:e_commerce_app/features/orders/presentation/cubit/order_cubit.dart';
import 'package:e_commerce_app/features/reviews/presentation/cubit/review_cubit.dart';
import 'package:e_commerce_app/features/reviews/presentation/widgets/make_new_review_loaded_body.dart';
import 'package:e_commerce_app/features/user/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MakeNewReviewPage extends StatefulWidget {
  const MakeNewReviewPage({super.key});

  static const String id = "kMakeNewReviewPage";

  @override
  State<MakeNewReviewPage> createState() => _MakeNewReviewPageState();
}

class _MakeNewReviewPageState extends State<MakeNewReviewPage> {

  @override
  void initState() {
    super.initState();
  }

  void checkUserReviewForProductRequest() {
    log("checkkkkkk");
    final int userId = BlocProvider.of<UserCubit>(context).getUserModel!.id!;
    final OrderItemModel orderItem =
        BlocProvider.of<OrderCubit>(context).getSelectedOrderItemModel!;

    BlocProvider.of<ReviewCubit>(context).checkUserReviewForProduct(
      productId: orderItem.product.id,
      userId: userId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundBodiesColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Product review",
          style: TextStyles.aDLaMDisplayBlackBold26,
        ),
      ),
      body: BlocBuilder<ReviewCubit, ReviewState>(
        buildWhen: (previous, current) {
          return current is ReviewNoNetworkErrorState ||
              current is CheckUserReviewForProductLoadedState ||
              current is UpdateReviewLoadedState ||
              current is CreateReviewLoadedState;
        },
        builder: (context, state) {
          if (state is ReviewNoNetworkErrorState) {
            return CustomNoInternetConnectionBody(
                onTryAgainPressed: checkUserReviewForProductRequest);
          } else if (state is CheckUserReviewForProductLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CheckUserReviewForProductLoadedState ||
              state is CreateReviewLoadedState ||
              state is UpdateReviewLoadedState) {
            return MakeNewReviewLoadedBody(
              checkUserReviewForProductModel:
                  (state as dynamic).checkUserReviewForProductModel,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
