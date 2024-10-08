import 'package:e_commerce_app/features/auth/data/models/log_out_response_model.dart';
import 'package:e_commerce_app/features/auth/data/models/login_response_model.dart';
import 'package:e_commerce_app/features/auth/data/models/verify_email_response_model.dart';

abstract class AuthRepository {
  Future<LogOutResponseModel> logOut();

  Future<LoginResponseModel> verifyLogin({
    required Map<String, dynamic> jsonData,
  });

  Future<void> createAccount({
    required Map<String, dynamic> jsonData,
  });

  Future<VerifyEmailResponseModel> verifyEmail({
    required String email,
    required String token,
  });

  Future<bool> sendVerification({required String email});
  Future<bool> checkIsEmailVerified({required String email});
}
