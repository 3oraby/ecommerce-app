import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_commerce_app/core/helpers/functions/show_snack_bar.dart';
import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/log_out_service.dart';
import 'package:e_commerce_app/features/auth/data/models/log_out_response_model.dart';
import 'package:e_commerce_app/pages/entry_page.dart';
import 'package:e_commerce_app/widgets/custom_trigger_button.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});
  static const id = "userProfilePage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: TextStyles.aDLaMDisplayBlackBold36,
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTriggerButton(
                buttonWidth: 150,
                buttonHeight: 50,
                borderWidth: 0,
                description: "log out",
                icon: Icons.logout,
                backgroundColor: Colors.white,
                descriptionColor: Colors.red,
                descriptionSize: 24,
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    title: "Are you sure to log out?",
                    animType: AnimType.topSlide,
                    showCloseIcon: true,
                    btnOkColor: Colors.red,
                    btnOkText: "Yes",
                    btnOkOnPress: () async {
                      //! log out
                      String accessToken =
                          SharedPreferencesSingleton.getString("accessToken");
                      log(accessToken);    
                      LogOutResponseModel logOutResponseModel =
                          await LogOutService().logOut(
                        accessToken: accessToken,
                      );
                      if (logOutResponseModel.status) {
                        showSnackBar(context, logOutResponseModel.message);
                        Navigator.pushReplacementNamed(context, EntryPage.id);
                      } else {
                        showSnackBar(context, logOutResponseModel.message);
                      }
                      //! navigate to entry page
                    },
                    btnCancelColor: ThemeColors.primaryColor,
                    btnCancelText: "NO",
                  ).show();
                  //! log out
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
