import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/show_error_with_internet_dialog.dart';
import 'package:e_commerce_app/core/helpers/functions/show_snack_bar.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/utils/validation/registration_validators.dart';
import 'package:e_commerce_app/core/utils/validation/validators.dart';
import 'package:e_commerce_app/core/widgets/custom_text_form_field.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/user/data/models/update_user_password_request_model.dart';
import 'package:e_commerce_app/features/user/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});
  static const String id = "kUpdatePasswordPage";

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  UpdateUserPasswordRequestModel updateUserPasswordRequestModel =
      UpdateUserPasswordRequestModel();

  bool isLoading = false;

  Future<void> changePassword(BuildContext context) async {
    oldPasswordController.text = oldPasswordController.text.trim();
    newPasswordController.text = newPasswordController.text.trim();
    confirmNewPasswordController.text = confirmNewPasswordController.text.trim();
    
    if (formKey.currentState!.validate()) {
      updateUserPasswordRequestModel.currentPassword =
          oldPasswordController.text;
      updateUserPasswordRequestModel.newPassword = newPasswordController.text;
      await BlocProvider.of<UserCubit>(context).updateUserPassword(
          jsonData: updateUserPasswordRequestModel.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundBodiesColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Change Password",
          style: TextStyles.aDLaMDisplayBlackBold26,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const VerticalGap(4),
                  Container(
                    color: Colors.white,
                    padding: LocalConstants.internalPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Old Password",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const VerticalGap(8),
                        CustomTextFormFieldWidget(
                          controller: oldPasswordController,
                          hintText: "Enter your old password..",
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: ThemeColors.primaryColor,
                          ),
                          isObscure: true,
                          validator: Validators.validateLoginPassword,
                          onChanged: (p0) {},
                        ),
                        const VerticalGap(24),
                        const Text(
                          "New Password",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const VerticalGap(8),
                        CustomTextFormFieldWidget(
                          controller: newPasswordController,
                          hintText: "Enter your new password..",
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: ThemeColors.primaryColor,
                          ),
                          isObscure: true,
                          validator: Validators.validateRegistrationPassword,
                          onChanged: (newPassword) {
                            newPasswordController.text = newPassword;
                          },
                        ),
                        const VerticalGap(24),
                        const Text(
                          "Confirm Your Password",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const VerticalGap(8),
                        CustomTextFormFieldWidget(
                          controller: confirmNewPasswordController,
                          hintText: "Confirm your new password..",
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: ThemeColors.primaryColor,
                          ),
                          isObscure: true,
                          validator: RegistrationValidators
                              .getConfirmPasswordValidator(
                                  newPasswordController.text),
                          onChanged: (p0) {},
                        ),
                        const VerticalGap(24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocListener<UserCubit, UserState>(
            listener: (context, state) {
              if (state is UserNoNetworkErrorState){
                showErrorWithInternetDialog(context);
              }
              else if (state is UpdateUserPasswordLoadingState) {
                setState(() {
                  isLoading = true;
                });
              } else if (state is UpdateUserPasswordErrorState) {
                setState(() {
                  isLoading = false;
                  showSnackBar(context, state.message,
                      backgroundColor: ThemeColors.errorColor);
                });
              } else if (state is UpdateUserPasswordLoadedState) {
                setState(() {
                  isLoading = false;
                  showSnackBar(
                      context, "Password has been updated successfully",
                      backgroundColor: ThemeColors.successfullyDoneColor);
                });
              }
            },
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.14,
              padding: LocalConstants.internalPadding,
              child: Center(
                child: CustomTriggerButton(
                  description: "Change Password",
                  descriptionSize: 22,
                  buttonHeight: 55,
                  onPressed: () async {
                    await changePassword(context);
                  },
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
