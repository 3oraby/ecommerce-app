import 'package:e_commerce_app/core/utils/navigation/home_page_navigation_service.dart';
import 'package:e_commerce_app/features/auth/constants/register_page_constants.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_commerce_app/features/auth/presentation/pages/login_page.dart';
import 'package:e_commerce_app/core/helpers/functions/custom_show_modal_bottom_sheet.dart';
import 'package:e_commerce_app/core/helpers/functions/show_snack_bar.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/auth_switch_widget.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/registration_step_form_field.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/user/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static const id = "registerPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // keys
  GlobalKey<FormState> formKey = GlobalKey();
  // controllers
  final PageController pageController = PageController();
  final ScrollController stepperScrollController = ScrollController();
  final ScrollController listViewScrollController = ScrollController();
  final TextEditingController textEditingController = TextEditingController();
  // models
  // RegisterRequestModel? registerRequestModel;
  // variables
  int completedSteps = 0;
  bool inAsyncCall = false;
  final Map<RegistrationStep, String?> stepValues = {};
  late UserCubit userCubit;
  late AuthCubit authCubit;

  @override
  void initState() {
    super.initState();
    userCubit = BlocProvider.of<UserCubit>(context);
    authCubit = BlocProvider.of<AuthCubit>(context);
    // registerRequestModel = authCubit.registerRequestModel;
  }

  // methods
  void scrollPageToBottom() {
    listViewScrollController.animateTo(
      listViewScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void scrollToActiveTile(int currentPage) {
    double offset = currentPage * 100;
    stepperScrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void onPageChanged(int currentPage) {
    scrollToActiveTile(currentPage);
    // Load the text value for the new step
    textEditingController.text = stepValues[stepsList[completedSteps]] ?? '';
  }

  Future<void> onContinuePressed(BuildContext context) async {
    if (completedSteps < stepsList.length) {
      // Save the current text value
      stepValues[stepsList[completedSteps]] = textEditingController.text;
      setState(() {
        completedSteps++;
      });

      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      authCubit.register();
    }
  }

  void onBackPressed() {
    if (completedSteps > 0) {
      if (completedSteps < stepsList.length) {
        // Save the current text value
        stepValues[stepsList[completedSteps]] = textEditingController.text;
      }
      setState(() {
        completedSteps--;
        if (stepsList[completedSteps] == RegistrationStep.confirmPassword) {
          // skip confirm password to change the password first
          completedSteps--;
        }
      });
      pageController.animateToPage(
        completedSteps,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    // dispose controllers
    pageController.dispose();
    stepperScrollController.dispose();
    listViewScrollController.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: inAsyncCall,
      child: Scaffold(
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is RegisterLoadingState ||
                state is VerifyEmailLoadingState) {
              setState(() {
                inAsyncCall = true;
              });
            } else if (state is RegisterLoadedState) {
              setState(() {
                inAsyncCall = true;
              });
              String link = state.verifyAccLink;
              Uri uri = Uri.parse(link);
              String token = uri.queryParameters['token']!;
              String email = uri.queryParameters['email']!;
              authCubit.verifyEmail(
                accessToken: token,
                email: email,
              );
            } else if (state is RegisterErrorState) {
              setState(() {
                inAsyncCall = false;
              });
              if (state.message == "Validation error") {
                showSnackBar(context, "Email is already in use");
              } else {
                showSnackBar(context, state.message);
              }
            } else if (state is VerifyEmailErrorState) {
              setState(() {
                inAsyncCall = false;
              });
              showSnackBar(context, state.message);
            } else if (state is VerifyEmailLoadedState) {
              setState(() {
                inAsyncCall = false;
              });
              userCubit.setUserModel(state.userModel);

              customShowModalBottomSheet(
                context: context,
                imageName: "assets/animations/orderSuccessfullyDone.json",
                sheetDescription:
                    "Congratulations! You have successfully registered. Welcome aboard! We're excited to have you with us.",
                onPressed: () {
                  HomePageNavigationService.navigateToHome();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    HomePage.id,
                    (Route<dynamic> route) => false,
                  );
                },
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              controller: listViewScrollController,
              reverse: true,
              children: [
                const VerticalGap(4),
                if (completedSteps != 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTriggerButton(
                        icon: Icons.arrow_back,
                        onPressed: onBackPressed,
                        buttonWidth: 70,
                        buttonHeight: 40,
                      ),
                    ],
                  ),
                const VerticalGap(8),
                Image.asset(
                  "assets/images/register_page.png",
                  height: 300,
                ),
                Text(
                  "Create account",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.pollerOne(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const VerticalGap(24),
                SizedBox(
                  // height: completedSteps < stepsList.length &&
                  //         stepsList[completedSteps] == RegistrationStep.image
                  //     ? 280
                  //     : 240,
                  height: 240,
                  child: Form(
                    key: formKey,
                    child: PageView(
                      controller: pageController,
                      onPageChanged: onPageChanged,
                      physics:
                          const NeverScrollableScrollPhysics(), // to prevent user scrolling
                      children: stepsList.map((step) {
                        return RegistrationStepFormField(
                          stepperScrollController: stepperScrollController,
                          textEditingController: textEditingController,
                          completedSteps: completedSteps,
                          scrollPageToBottom: scrollPageToBottom,
                          stepValues: stepValues,
                          // registerRequestModel: registerRequestModel,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const VerticalGap(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTriggerButton(
                      description: completedSteps == stepsList.length
                          ? "Create account"
                          : "Continue",
                      backgroundColor: completedSteps == stepsList.length
                          ? ThemeColors.secondaryColor
                          : ThemeColors.primaryColor,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await onContinuePressed(context);
                        }
                      },
                      descriptionColor: Colors.white,
                      buttonWidth: 300,
                    ),
                  ],
                ),
                AuthSwitchWidget(
                  promptText: "already have an account ?",
                  actionText: "Login",
                  onActionPressed: () {
                    Navigator.pushReplacementNamed(context, LoginPage.id);
                  },
                ),
                const VerticalGap(48),
              ].reversed.toList(),
            ),
          ),
        ),
      ),
    );
  }
}
