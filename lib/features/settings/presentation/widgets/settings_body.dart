import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/show_error_with_internet_dialog.dart';
import 'package:e_commerce_app/core/helpers/functions/show_snack_bar.dart';
import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce_app/core/utils/navigation/home_page_navigation_service.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_commerce_app/core/widgets/custom_option_list_tile.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/user/presentation/pages/edit_user_profile_page.dart';
import 'package:e_commerce_app/features/user/presentation/pages/update_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({super.key});

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  bool isPageLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LogOutLoadingState) {
          setState(() {
            isPageLoading = true;
          });
        } else if (state is AuthNoNetworkErrorState) {
          setState(() {
            isPageLoading = false;
          });
          showErrorWithInternetDialog(context);
        } else if (state is LogOutErrorState) {
          setState(() {
            isPageLoading = false;
          });
          showSnackBar(context, state.message);
        } else if (state is LogOutLoadedState) {
          setState(() {
            isPageLoading = false;
          });
          HomePageNavigationService.navigateToHome();
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomePage.id,
            (Route<dynamic> route) => false,
          );
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isPageLoading,
        child: ListView(
          children: [
            const VerticalGap(16),
            CustomOptionListTile(
              leadingIcon: FontAwesomeIcons.user,
              title: 'Edit Profile',
              onTap: () {
                Navigator.pushNamed(context, EditUserProfilePage.id);
              },
            ),
            const VerticalGap(16),
            CustomOptionListTile(
              leadingIcon: FontAwesomeIcons.lock,
              title: 'Change Password',
              onTap: () {
                Navigator.pushNamed(context, UpdatePasswordPage.id);
              },
            ),
            const VerticalGap(16),
            CustomOptionListTile(
              leadingIcon: FontAwesomeIcons.rightFromBracket,
              title: 'Logout',
              leadingIconColor: ThemeColors.errorColor,
              onTap: () {
                _showLogoutDialog(context);
              },
            ),
            const VerticalGap(16),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: ThemeColors.primaryColor),
              ),
            ),
            CustomTriggerButton(
              buttonWidth: 100,
              buttonHeight: 40,
              backgroundColor: ThemeColors.actionButtonsBackgroundColor,
              description: "Log Out",
              descriptionSize: 16,
              descriptionColor: ThemeColors.errorColor,
              onPressed: () async {
                Navigator.of(context).pop();
                SharedPreferencesSingleton.deleteStringFromSharedPreferences(
                    LocalConstants.userAddressModelInPref);
                SharedPreferencesSingleton.deleteStringFromSharedPreferences(
                    LocalConstants.userModelNameInPref);
                BlocProvider.of<AuthCubit>(context).logOut();
              },
            ),
          ],
        );
      },
    );
  }
}
