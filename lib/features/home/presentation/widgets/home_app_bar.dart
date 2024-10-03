import 'package:e_commerce_app/core/helpers/functions/is_user_signed_in.dart';
import 'package:e_commerce_app/core/helpers/functions/show_not_signed_in_dialog.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/core/utils/app_assets/images/app_images.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/features/user/presentation/cubit/user_cubit.dart';
import 'package:e_commerce_app/features/user/presentation/pages/edit_user_profile_page.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAppBar {
  static AppBar getHomeAppBar({
    required BuildContext context,
  }) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      title: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          final UserModel? userModel = context.read<UserCubit>().getUserModel;

          final String displayName =
              userModel != null ? userModel.userName!.split(' ').first : "User";

          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  isUserSignedIn()
                      ? Navigator.pushNamed(context, EditUserProfilePage.id)
                      : showNotSignedInDialog(context);
                },
                child: Image.asset(
                  AppImages.imagesUserPhoto,
                  width: 50,
                  height: 50,
                ),
              ),
              const HorizontalGap(24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi, $displayName",
                      style: TextStyles.aDLaMDisplayBlackBold24,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Text(
                      "let's go shopping",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
