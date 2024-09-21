import 'dart:developer';

import 'package:e_commerce_app/core/helpers/functions/is_user_signed_in.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/core/utils/app_assets/images/app_images.dart';
import 'package:e_commerce_app/features/user/presentation/cubit/user_cubit.dart';
import 'package:e_commerce_app/features/user/presentation/pages/edit_user_profile_page.dart';
import 'package:e_commerce_app/core/widgets/horizontal_gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar {
  static AppBar getHomeAppBar({
    required BuildContext context,
  }) {
    final UserModel? userModel =
        BlocProvider.of<UserCubit>(context).getUserModel;

    final String displayName;
    if (userModel != null) {
      final nameParts = userModel.userName?.split(' ');
      displayName =
          nameParts != null && nameParts.isNotEmpty ? nameParts.first : 'User';
    } else {
      displayName = "User";
    }
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              log(isUserSignedIn().toString());
              Navigator.pushNamed(context, EditUserProfilePage.id);
            },
            child: Image.asset(
              AppImages.userPhoto,
              width: 50,
              height: 50,
            ),
          ),
          const HorizontalGap(24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, $displayName",
                style: GoogleFonts.aDLaMDisplay(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "let's go shopping",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
