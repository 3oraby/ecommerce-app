part of 'user_cubit.dart';

abstract class UserState {}

final class UserInitial extends UserState {}

final class GetUserLoadingState extends UserState {}

final class GetUserErrorState extends UserState {
  final String message;

  GetUserErrorState({required this.message});
}

final class GetUserLoadedState extends UserState {
  final GetUserResponseModel getUserResponseModel;

  GetUserLoadedState({required this.getUserResponseModel});
}

final class UpdateUserLoadingState extends UserState {}

final class UpdateUserErrorState extends UserState {
  final String message;

  UpdateUserErrorState({required this.message});
}

final class UpdateUserLoadedState extends UserState {}

final class UpdateUserPasswordLoadingState extends UserState {}

final class UpdateUserPasswordErrorState extends UserState {
  final String message;

  UpdateUserPasswordErrorState({required this.message});
}

final class UpdateUserPasswordLoadedState extends UserState {}


