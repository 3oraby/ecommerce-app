import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/features/user/data/models/get_user_response_model.dart';
import 'package:e_commerce_app/features/user/data/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;
  late UserModel userModel;
  UserCubit({
    required this.userRepository,
  }) : super(UserInitial());

  UserModel get getUserModel => userModel;

  Future<void> getUser() async {
    emit(GetUserLoadingState());
    try {
      final GetUserResponseModel getUserResponseModel =
          await userRepository.getUser();
      if (getUserResponseModel.status) {
        userModel = getUserResponseModel.user!;
        emit(GetUserLoadedState(
          getUserResponseModel: getUserResponseModel,
        ));
      } else {
        emit(GetUserErrorState(
            message: 'Failed to get user: ${getUserResponseModel.message}'));
      }
    } catch (e) {
      emit(GetUserErrorState(
        message: 'Failed to get user: $e',
      ));
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
}
