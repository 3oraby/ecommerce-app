import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce_app/features/auth/data/models/log_out_response_model.dart';
import 'package:e_commerce_app/features/auth/data/models/register_request_model.dart';
import 'package:e_commerce_app/features/user/data/models/get_user_response_model.dart';
import 'package:e_commerce_app/features/user/data/repositories/user_repository.dart';
import 'package:e_commerce_app/features/user/presentation/utils/get_user_stored_model.dart';
import 'package:e_commerce_app/features/user/presentation/utils/save_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;
  UserCubit({
    required this.userRepository,
  }) : super(UserInitial());

  RegisterRequestModel registerRequestModel = RegisterRequestModel();

  void setUserModel(UserModel user) {
    saveUserModel(user);
  }

  UserModel? get getUserModel => getUserStoredModel();

  Future<UserModel> getUser() async {
    try {
      final GetUserResponseModel getUserResponseModel =
          await userRepository.getUser();
      if (getUserResponseModel.status) {
        saveUserModel(getUserResponseModel.user!);
        return getUserStoredModel()!;
      } else {
        throw Exception("Failed to get user");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateUser({
    required int userId,
    required Map<String, dynamic> jsonData,
  }) async {
    emit(UpdateUserLoadingState());
    try {
      final bool isUpdated = await userRepository.updateUser(
        userId: userId,
        jsonData: jsonData,
      );
      if (isUpdated) {
        saveUserModel(await getUser());
        emit(UpdateUserLoadedState());
      } else {
        emit(UpdateUserErrorState(
          message: 'Failed to update user',
        ));
      }
    } catch (e) {
      emit(UpdateUserErrorState(
        message: 'Failed to update user: $e',
      ));
    }
  }

  Future<void> updateUserPassword({
    required Map<String, dynamic> jsonData,
  }) async {
    emit(UpdateUserPasswordLoadingState());
    try {
      final bool isUpdated = await userRepository.updateUserPassword(
        jsonData: jsonData,
      );
      if (isUpdated) {
        emit(UpdateUserPasswordLoadedState());
      } else {
        emit(UpdateUserPasswordErrorState(
          message: 'Old password not Correct',
        ));
      }
    } catch (e) {
      emit(UpdateUserPasswordErrorState(
        message: 'Failed to update password $e',
      ));
    }
  }

  Future<void> logOut() async {
    emit(LogOutLoadingState());
    try {
      LogOutResponseModel logOutResponseModel = await userRepository.logout();

      if (logOutResponseModel.status) {
        emit(LogOutLoadedState());
        SharedPreferencesSingleton.deleteStringFromSharedPreferences(
            LocalConstants.accessTokenNameInPref);
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
