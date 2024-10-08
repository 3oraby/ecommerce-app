part of 'auth_cubit.dart';

abstract class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthNoNetworkErrorState extends AuthState {}

final class LoginLoadingState extends AuthState {}

final class LoginLoadedState extends AuthState {
  final UserModel userModel;
  LoginLoadedState({required this.userModel});
}

final class LoginErrorState extends AuthState {
  final String message;
  LoginErrorState({required this.message});
}

final class RegisterLoadingState extends AuthState {}

final class RegisterLoadedState extends AuthState {}

final class RegisterErrorState extends AuthState {
  final String message;
  RegisterErrorState({required this.message});
}

final class VerifyEmailLoadingState extends AuthState {}

final class VerifyEmailLoadedState extends AuthState {
  final UserModel userModel;
  VerifyEmailLoadedState({required this.userModel});
}

final class VerifyEmailErrorState extends AuthState {
  final String message;
  VerifyEmailErrorState({required this.message});
}

final class LogOutLoadingState extends AuthState {}

final class LogOutLoadedState extends AuthState {}

final class LogOutErrorState extends AuthState {
  final String message;
  LogOutErrorState({required this.message});
}

final class CheckIsEmailVerifiedLoadingState extends AuthState {}

final class CheckIsEmailVerifiedLoadedState extends AuthState {}

final class CheckIsEmailVerifiedErrorState extends AuthState {
  final String message;
  CheckIsEmailVerifiedErrorState({required this.message});
}

class ResendVerificationLoadingState extends AuthState {}

class ResendVerificationSuccessState extends AuthState {}

class ResendVerificationErrorState extends AuthState {
  final String message;
  ResendVerificationErrorState({required this.message});
}
