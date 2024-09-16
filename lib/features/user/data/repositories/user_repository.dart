import 'package:e_commerce_app/features/auth/data/models/log_out_response_model.dart';
import 'package:e_commerce_app/features/user/data/models/get_user_response_model.dart';

abstract class UserRepository {
  Future<GetUserResponseModel> getUser();

  Future<bool> updateUser({
    required int userId,
    required Map<String, dynamic> jsonData,
  });

  Future<LogOutResponseModel> logout();

  Future<bool> updateUserPassword({required Map<String, dynamic> jsonData});
}
