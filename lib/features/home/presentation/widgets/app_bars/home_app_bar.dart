import 'package:e_commerce_app/core/utils/app_assets/images/app_images.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/user/presentation/pages/user_profile_page.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:e_commerce_app/widgets/horizontal_gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar{
  static AppBar getHomeAppBar({
    required UserModel userModel,
    required BuildContext context,
  }) {
    return AppBar(
      elevation: 0,
      actionsIconTheme: const IconThemeData(
        color: ThemeColors.primaryColor,
      ),
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, UserProfilePage.id);
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
                "Hi, ${userModel.userName}",
                style: GoogleFonts.aDLaMDisplay(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "let`s go shopping",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
      // actions: [
      //   IconButton(
      //     onPressed: () {
      //       Navigator.pushNamed(context, ShowProductsPage.id);
      //     },
      //     icon: const Icon(
      //       Icons.search,
      //       size: 40,
      //     ),
      //   ),
      // ],
    );
  }
}