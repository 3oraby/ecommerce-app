import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/features/auth/data/models/log_out_response_model.dart';
import 'package:e_commerce_app/features/user/data/models/get_user_response_model.dart';
import 'package:e_commerce_app/features/user/data/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;
  UserModel? userModel;
  UserCubit({
    required this.userRepository,
  }) : super(UserInitial());

  void setUserModel(UserModel user) {
    userModel = user;
  }

  UserModel? get getUserModel => userModel;

  Future<UserModel> getUser() async {
    try {
      final GetUserResponseModel getUserResponseModel =
          await userRepository.getUser();
      if (getUserResponseModel.status) {
        userModel = getUserResponseModel.user!;
        return userModel!;
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
        userModel = await getUser();
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

  Future<void> logOut() async {
    emit(LogOutLoadingState());
    try {
      LogOutResponseModel logOutResponseModel = await userRepository.logout();

      if (logOutResponseModel.status) {
        emit(LogOutLoadedState());
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
