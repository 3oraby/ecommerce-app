import 'package:e_commerce_app/core/models/user_model.dart';

class AuthScreenArguments {
  final UserModel userModel;
  final String accessToken;
  AuthScreenArguments({
    required this.userModel,
    required this.accessToken,
  });
}
