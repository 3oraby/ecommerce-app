import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/helpers/functions/check_connection_with_internet.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce_app/features/auth/data/models/log_out_response_model.dart';
import 'package:e_commerce_app/features/auth/data/models/login_response_model.dart';
import 'package:e_commerce_app/features/auth/data/models/register_request_model.dart';
import 'package:e_commerce_app/features/auth/data/models/register_response_model.dart';
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
      final RegisterResponseModel registerResponseModel = await authRepository
          .createAccount(jsonData: registerRequestModel.toJson());
      if (registerResponseModel.status) {
        emit(RegisterLoadedState(
            verifyAccLink: registerResponseModel.verifyAccLink!));
      } else {
        emit(RegisterErrorState(message: registerResponseModel.message!));
      }
    } catch (e) {
      RegisterErrorState(
          message:
              'Failed to create account now , please try again later : $e');
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
}
