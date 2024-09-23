import 'dart:developer';

import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce_app/core/utils/navigation/home_page_navigation_service.dart';
import 'package:e_commerce_app/features/address/presentation/pages/add_address_page.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/login_service.dart';
import 'package:e_commerce_app/features/auth/data/models/login_request_model.dart';
import 'package:e_commerce_app/features/auth/data/models/login_response_model.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/auth_switch_widget.dart';
import 'package:e_commerce_app/core/helpers/functions/custom_show_modal_bottom_sheet.dart';
import 'package:e_commerce_app/core/helpers/functions/show_snack_bar.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/core/utils/validation/validators.dart';
import 'package:e_commerce_app/core/widgets/custom_text_form_field.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/user/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const id = "loginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isAsyncCall = false;
  final LoginRequestModel loginRequestModel = LoginRequestModel();

  Future<void> handleLogin(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isAsyncCall = true;
      });
      try {
        final LoginResponseModel loginResponseModel =
            await LoginService().verifyLogin(
          jsonData: loginRequestModel.toJson(),
        );
        log("login ${loginResponseModel.status}");

        if (loginResponseModel.status) {
          final String accessToken = loginResponseModel.accessToken!;
          SharedPreferencesSingleton.setString(LocalConstants.accessTokenNameInPref, accessToken);

          BlocProvider.of<UserCubit>(context)
              .setUserModel(loginResponseModel.user!);

          customShowModalBottomSheet(
            context: context,
            imageName: "assets/animations/orderSuccessfullyDone.json",
            sheetDescription:
                "You've logged in successfully. Great to see you again!",
            onPressed: () {
              HomePageNavigationService.navigateToHome();
              Navigator.pushNamedAndRemoveUntil(
                context,
                HomePage.id,
                (Route<dynamic> route) => false,
              );
            },
          );
        } else {
          showSnackBar(context, loginResponseModel.message!);
        }
      } on Exception catch (e) {
        showSnackBar(context, e.toString());
      } finally {
        setState(() {
          isAsyncCall = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isAsyncCall,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: ListView(
              reverse: true,
              children: [
                Image.asset(
                  "assets/images/register_page.png",
                  height: 300,
                ),
                Text(
                  "Log in",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.pollerOne(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const VerticalGap(30),
                CustomTextFormFieldWidget(
                  labelText: "Email",
                  onChanged: (email) {
                    loginRequestModel.email = email;
                  },
                  validator: Validators.emailValidator,
                ),
                const VerticalGap(30),
                CustomTextFormFieldWidget(
                  labelText: "Password",
                  isObscure: true,
                  onChanged: (password) {
                    loginRequestModel.password = password;
                  },
                  validator: Validators.validateLoginPassword,
                ),
                const VerticalGap(30),
                CustomTriggerButton(
                  onPressed: () {
                    handleLogin(context);
                  },
                  description: "Log In",
                ),
                AuthSwitchWidget(
                  promptText: "don't have an account?",
                  actionText: "Register",
                  onActionPressed: () {
                    Navigator.pushReplacementNamed(context, AddAddressPage.id);
                  },
                ),
                const VerticalGap(100),
              ].reversed.toList(),
            ),
          ),
        ),
      ),
    );
  }
}
