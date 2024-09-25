import 'dart:developer';

import 'package:e_commerce_app/core/helpers/functions/show_error_with_internet_dialog.dart';
import 'package:e_commerce_app/core/utils/app_assets/images/app_images.dart';
import 'package:e_commerce_app/core/utils/navigation/home_page_navigation_service.dart';
import 'package:e_commerce_app/features/address/presentation/pages/add_address_page.dart';
import 'package:e_commerce_app/features/auth/data/models/login_request_model.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart';
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
  late AuthCubit authCubit;
  @override
  void initState() {
    super.initState();
    authCubit = BlocProvider.of<AuthCubit>(context);
  }

  Future<void> _handleLogin() async {
    if (formKey.currentState!.validate()) {
      authCubit.login(
        jsonData: loginRequestModel.toJson(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isAsyncCall,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            log(state.toString());
            if (state is AuthNoNetworkErrorState) {
              setState(() {
                isAsyncCall = false;
              });
              showErrorWithInternetDialog(context);
            } else if (state is LoginLoadingState) {
              setState(() {
                isAsyncCall = true;
              });
            } else if (state is LoginLoadedState) {
              setState(() {
                isAsyncCall = false;
              });
              BlocProvider.of<UserCubit>(context).setUserModel(state.userModel);

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
            } else if (state is LoginErrorState) {
              setState(() {
                isAsyncCall = false;
              });
              showSnackBar(context, state.message);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: formKey,
              child: ListView(
                reverse: true,
                children: [
                  Image.asset(
                    AppImages.imagesLoginPage,
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
                    prefixIcon: const Icon(Icons.email),
                    onChanged: (email) {
                      loginRequestModel.email = email;
                    },
                    validator: Validators.emailValidator,
                  ),
                  const VerticalGap(30),
                  CustomTextFormFieldWidget(
                    labelText: "Password",
                    isObscure: true,
                    prefixIcon: const Icon(Icons.lock),
                    onChanged: (password) {
                      loginRequestModel.password = password;
                    },
                    validator: Validators.validateLoginPassword,
                  ),
                  const VerticalGap(30),
                  CustomTriggerButton(
                    onPressed: _handleLogin,
                    description: "Log In",
                  ),
                  AuthSwitchWidget(
                    promptText: "don't have an account?",
                    actionText: "Register",
                    onActionPressed: () {
                      Navigator.pushReplacementNamed(
                          context, AddAddressPage.id);
                    },
                  ),
                  const VerticalGap(100),
                ].reversed.toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
