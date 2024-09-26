import 'package:e_commerce_app/features/user/data/models/get_user_response_model.dart';

abstract class UserRepository {
  Future<GetUserResponseModel> getUser();

  Future<bool> updateUser({
    required int userId,
    required Map<String, dynamic> jsonData,
  });


  Future<bool> updateUserPassword({required Map<String, dynamic> jsonData});
}
