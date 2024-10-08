import 'dart:developer';

import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/check_connection_with_internet.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce_app/features/auth/data/models/log_out_response_model.dart';
import 'package:e_commerce_app/features/auth/data/models/login_response_model.dart';
import 'package:e_commerce_app/features/auth/data/models/register_request_model.dart';
import 'package:e_commerce_app/features/auth/data/models/verify_email_response_model.dart';
import 'package:e_commerce_app/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepository}) : super(AuthInitial());

  final AuthRepository authRepository;
  RegisterRequestModel registerRequestModel = RegisterRequestModel();

  Future<void> login({required Map<String, dynamic> jsonData}) async {
    if (!await checkConnectionWithInternet()) {
      emit(AuthNoNetworkErrorState());
      return;
    }
    emit(LoginLoadingState());
    try {
      final LoginResponseModel loginResponseModel =
          await authRepository.verifyLogin(jsonData: jsonData);
      if (loginResponseModel.status) {
        final String accessToken = loginResponseModel.accessToken!;
        SharedPreferencesSingleton.setString(
            LocalConstants.accessTokenNameInPref, accessToken);
        emit(LoginLoadedState(userModel: loginResponseModel.user!));
      } else {
        emit(LoginErrorState(message: loginResponseModel.message!));
      }
    } catch (e) {
      LoginErrorState(
          message: 'Failed to login now , please try again later : $e');
    }
  }

  Future<void> register() async {
    if (!await checkConnectionWithInternet()) {
      emit(AuthNoNetworkErrorState());
      return;
    }
    emit(RegisterLoadingState());
    try {
      await authRepository.createAccount(
          jsonData: registerRequestModel.toJson());
      emit(RegisterLoadedState());
    } catch (e) {
      log("exception in authCubit.register : $e");
      if (e.toString().contains("Email is already in use")) {
        emit(RegisterErrorState(message: "This email is already in use."));
      } else if (e.toString().contains("Network error")) {
        emit(RegisterErrorState(
            message: "Please check your internet connection."));
      } else {
        emit(RegisterErrorState(
            message: "Failed to create account. Please try again later."));
      }
    }
  }

  Future<void> verifyEmail(
      {required String email, required String accessToken}) async {
    if (!await checkConnectionWithInternet()) {
      emit(AuthNoNetworkErrorState());
      return;
    }
    emit(VerifyEmailLoadingState());
    try {
      final VerifyEmailResponseModel verifyEmailResponseModel =
          await authRepository.verifyEmail(email: email, token: accessToken);
      if (verifyEmailResponseModel.status) {
        emit(VerifyEmailLoadedState(userModel: verifyEmailResponseModel.user!));
        final String accessToken = verifyEmailResponseModel.accessToken!;
        SharedPreferencesSingleton.setString(
            LocalConstants.accessTokenNameInPref, accessToken);
      } else {
        emit(VerifyEmailErrorState(message: verifyEmailResponseModel.message!));
      }
    } catch (e) {
      VerifyEmailErrorState(
          message:
              'Failed to create account now , please try again later : $e');
    }
  }

  Future<void> logOut() async {
    if (!await checkConnectionWithInternet()) {
      emit(AuthNoNetworkErrorState());
      return;
    }
    emit(LogOutLoadingState());
    try {
      LogOutResponseModel logOutResponseModel = await authRepository.logOut();

      if (logOutResponseModel.status) {
        emit(LogOutLoadedState());
        SharedPreferencesSingleton.deleteStringFromSharedPreferences(
            LocalConstants.accessTokenNameInPref);
        SharedPreferencesSingleton.deleteStringFromSharedPreferences(
            LocalConstants.refreshTokenNameInPref);
      } else {
        emit(LogOutErrorState(
          message: logOutResponseModel.message,
        ));
      }
    } catch (e) {
      emit(LogOutErrorState(
        message: 'Failed to log out : $e',
      ));
    }
  }

  Future<void> checkIsEmailVerified({required String email}) async {
    if (!await checkConnectionWithInternet()) {
      emit(AuthNoNetworkErrorState());
      return;
    }
    emit(CheckIsEmailVerifiedLoadingState());
    try {
      bool successRequest =
          await authRepository.checkIsEmailVerified(email: email);
      if (successRequest) {
        emit(CheckIsEmailVerifiedLoadedState());
      } else {
        emit(CheckIsEmailVerifiedErrorState(
            message:
                'Email verification is incomplete. Please verify your email before proceeding.'));
      }
    } catch (e) {
      emit(CheckIsEmailVerifiedErrorState(
          message: "Failed to check if email Verified: $e"));
    }
  }

  Future<void> resendVerificationEmail({required String email}) async {
    if (!await checkConnectionWithInternet()) {
      emit(AuthNoNetworkErrorState());
      return;
    }
    emit(ResendVerificationLoadingState());
    try {
      bool successRequest = await authRepository.sendVerification(email: email);
      if (successRequest) {
        emit(ResendVerificationSuccessState());
      } else {
        emit(ResendVerificationErrorState(
            message: "Failed to resend verification email, Please try again."));
      }
    } catch (e) {
      emit(ResendVerificationErrorState(
          message: 'Failed to resend verification email: $e'));
    }
  }
}
