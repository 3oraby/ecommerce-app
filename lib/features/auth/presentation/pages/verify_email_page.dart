import 'dart:async';

import 'package:e_commerce_app/core/helpers/functions/custom_show_modal_bottom_sheet.dart';
import 'package:e_commerce_app/core/helpers/functions/show_custom_snack_bar.dart';
import 'package:e_commerce_app/core/helpers/functions/show_error_with_internet_dialog.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_commerce_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});
  static const id = "kVerifyEmailPage";

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool _resendEnabled = false; // Disabled initially
  int _resendCountdown = 90; // 90 seconds countdown
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendTimer(); // Start timer when page opens
  }

  void _startResendTimer() {
    setState(() {
      _resendEnabled = false;
      _resendCountdown = 90; // Reset countdown to 90 seconds
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendCountdown > 0) {
          _resendCountdown--;
        } else {
          _resendEnabled = true; // Re-enable button after countdown ends
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    String userEmail = authCubit.registerRequestModel.email ?? "";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Your Email'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ThemeColors.primaryColor,
        toolbarHeight: 80,
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ResendVerificationLoadingState) {
            showCustomSnackBar(context, 'Resending verification email...');
          } else if (state is ResendVerificationSuccessState) {
            showCustomSnackBar(
                context, 'Verification email sent successfully!');
            _startResendTimer(); // Start timer when email is resent
          } else if (state is ResendVerificationErrorState) {
            showCustomSnackBar(context, state.message);
            setState(() {
              _resendEnabled = true; // Allow resending after error
            });
          }

          if (state is CheckIsEmailVerifiedErrorState) {
            showCustomSnackBar(context, state.message);
          } else if (state is CheckIsEmailVerifiedLoadedState) {
            customShowModalBottomSheet(
              context: context,
              imageName: "assets/animations/success_done2.json",
              buttonDescription: "go to LoginPage",
              sheetDescription:
                  "Congratulations on your successful registration! Welcome aboard—we're thrilled to have you. Please log in to get started.",
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginPage.id,
                  (Route<dynamic> route) => false,
                );
              },
            );
          } else if (state is AuthNoNetworkErrorState) {
            showErrorWithInternetDialog(context);
          }
        },
        builder: (context, state) => Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.email,
                        size: 60, color: ThemeColors.primaryColor),
                    const VerticalGap(16),
                    const Text(
                      'Verify Your Email',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const VerticalGap(12),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'We\'ve sent a confirmation link to your email ',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: userEmail,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ThemeColors.primaryColor,
                              fontSize: 16,
                            ),
                          ),
                          const TextSpan(
                            text:
                                '. Please check your inbox and verify to proceed.',
                          ),
                        ],
                      ),
                    ),
                    const VerticalGap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Didn’t receive anything?',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: _resendEnabled
                              ? () => authCubit.resendVerificationEmail(
                                  email: userEmail)
                              : null,
                          child: (state is ResendVerificationLoadingState)
                              ? const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: ThemeColors.primaryColor,
                                  ),
                                )
                              : Text(
                                  _resendEnabled
                                      ? 'Resend Code'
                                      : 'Resend Code (${_resendCountdown}s)',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: _resendEnabled
                                        ? ThemeColors.primaryColor
                                        : Colors.grey,
                                  ),
                                ),
                        ),
                      ],
                    ),
                    const VerticalGap(8),
                    CustomTriggerButton(
                      buttonHeight: 55,
                      icon: Icons.check,
                      description: "I Have Verified My Email",
                      descriptionSize: 18,
                      iconSize: 25,
                      onPressed: () {
                        authCubit.checkIsEmailVerified(email: userEmail);
                      },
                      child: (state is CheckIsEmailVerifiedLoadingState)
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
