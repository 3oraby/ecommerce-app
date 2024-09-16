import 'package:e_commerce_app/features/auth/data/data_sources/log_out_service.dart';
import 'package:e_commerce_app/features/auth/data/models/log_out_response_model.dart';
import 'package:e_commerce_app/features/user/data/data_sources/get_user_service.dart';
import 'package:e_commerce_app/features/user/data/data_sources/update_user_password_service.dart';
import 'package:e_commerce_app/features/user/data/data_sources/update_user_service.dart';
import 'package:e_commerce_app/features/user/data/models/get_user_response_model.dart';
import 'package:e_commerce_app/features/user/data/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final GetUserService getUserService;
  final UpdateUserService updateUserService;
  final LogOutService logOutService;
  final UpdateUserPasswordService updateUserPasswordService;

  UserRepositoryImpl({
    required this.getUserService,
    required this.updateUserService,
    required this.logOutService,
    required this.updateUserPasswordService,
  });

  @override
  Future<GetUserResponseModel> getUser() async {
    return await getUserService.getUser();
  }

  @override
  Future<bool> updateUser({
    required int userId,
    required Map<String, dynamic> jsonData,
  }) async {
    return await updateUserService.updateUser(
      userId: userId,
      jsonData: jsonData,
    );
  }

  @override
  Future<LogOutResponseModel> logout() async {
    return await logOutService.logOut();
  }

  @override
  Future<bool> updateUserPassword(
      {required Map<String, dynamic> jsonData}) async {
    return await updateUserPasswordService.updateUserPassword(
        jsonData: jsonData);
  }
}
