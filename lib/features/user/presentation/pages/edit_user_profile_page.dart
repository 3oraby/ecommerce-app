import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/show_snack_bar.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/core/utils/validation/validators.dart';
import 'package:e_commerce_app/core/widgets/custom_text_form_field.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/user/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class EditUserProfilePage extends StatefulWidget {
  const EditUserProfilePage({super.key});
  static const String id = "kEditUserProfilePage";

  @override
  State<EditUserProfilePage> createState() => _EditUserProfilePageState();
}

class _EditUserProfilePageState extends State<EditUserProfilePage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  bool isLoading = false;
  bool isFormChanged = false;
  UserCubit? userCubit;
  UserModel? userModel;

  String? initialName;
  String? initialPhoneNumber;

  @override
  void initState() {
    super.initState();
    userCubit = BlocProvider.of<UserCubit>(context);
    userModel = userCubit!.getUserModel;

    if (userModel != null) {
      setInitialValuesToController();
    }

    emailController.addListener(onFormChanged);
    nameController.addListener(onFormChanged);
    phoneNumberController.addListener(onFormChanged);
  }

  void setInitialValuesToController() {
    emailController.text = userModel!.email ?? '';
    nameController.text = userModel!.userName ?? '';
    phoneNumberController.text = userModel!.phoneNumber ?? '';

    initialName = userModel!.userName;
    initialPhoneNumber = userModel!.phoneNumber;
  }

  void onFormChanged() {
    setState(() {
      isFormChanged = nameController.text.trim() != initialName?.trim() ||
          phoneNumberController.text.trim() != initialPhoneNumber?.trim();
    });
  }

  Future<void> updateProfile(BuildContext context) async {
    nameController.text = nameController.text.trim();
    phoneNumberController.text = phoneNumberController.text.trim();

    if (formKey.currentState!.validate()) {
      await userCubit!.updateUser(
        userId: userModel!.id!,
        jsonData: getJsonRequestData(),
      );
    }
  }

  Map<String, dynamic> getJsonRequestData() {
    return {
      "user_name": nameController.text,
      "email": emailController.text,
      "phone_number": phoneNumberController.text,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundBodiesColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Edit Profile",
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: LocalConstants.kHorizontalPadding,
                      vertical: 16,
                    ),
                    child: Container(
                      padding: LocalConstants.internalPadding,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          LocalConstants.kBorderRadius,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const VerticalGap(16),
                          const Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                          const VerticalGap(4),
                          CustomTextFormFieldWidget(
                            controller: emailController,
                            hintText: "Enter your email",
                            fillColor: Colors.white,
                            textStyle: GoogleFonts.rubik(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            isEnabled: false,
                            makeBorderForTextField: false,
                            prefixIcon: const Icon(
                              Icons.email,
                              color: ThemeColors.primaryColor,
                            ),
                          ),
                          const VerticalGap(24),
                          const Text(
                            "Name",
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                          const VerticalGap(4),
                          CustomTextFormFieldWidget(
                            controller: nameController,
                            hintText: "Enter your name",
                            fillColor: Colors.white,
                            makeBorderForTextField: false,
                            textStyle: GoogleFonts.rubik(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: ThemeColors.primaryColor,
                            ),
                            suffixIcon: const Icon(
                              Icons.edit,
                            ),
                            validator: Validators.requiredFieldValidator,
                          ),
                          const VerticalGap(24),
                          const Text(
                            "Phone Number",
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                          const VerticalGap(4),
                          CustomTextFormFieldWidget(
                            controller: phoneNumberController,
                            hintText: "Enter your phone number",
                            fillColor: Colors.white,
                            makeBorderForTextField: false,
                            keyboardType: TextInputType.number,
                            textStyle: GoogleFonts.rubik(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            prefixIcon: const Icon(
                              Icons.phone,
                              color: ThemeColors.primaryColor,
                            ),
                            suffixIcon: const Icon(
                              Icons.edit,
                            ),
                            validator: Validators.phoneValidator,
                          ),
                          const VerticalGap(24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocListener<UserCubit, UserState>( 
            listener: (context, state) {
              if (state is UpdateUserLoadingState) {
                setState(() {
                  isLoading = true;
                });
              } else if (state is UpdateUserErrorState) {
                setState(() {
                  isLoading = false;
                  showSnackBar(context, state.message,
                      backgroundColor: ThemeColors.errorColor);
                });
              } else if (state is UpdateUserLoadedState) {
                setState(() {
                  isLoading = false;
                  initialName = nameController.text;
                  initialPhoneNumber = phoneNumberController.text;
                  isFormChanged = false; // Reset form changed status
                  showSnackBar(context, "Profile updated successfully",
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
                  description: "SAVE",
                  descriptionSize: 22,
                  backgroundColor: isFormChanged
                      ? ThemeColors.primaryColor
                      : ThemeColors.unEnabledButtonsColor,
                  buttonHeight: 55,
                  onPressed: isFormChanged
                      ? () async {
                          await updateProfile(context);
                        }
                      : null,
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

  @override
  void dispose() {
    emailController.removeListener(onFormChanged);
    nameController.removeListener(onFormChanged);
    phoneNumberController.removeListener(onFormChanged);

    emailController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();

    super.dispose();
  }
}
