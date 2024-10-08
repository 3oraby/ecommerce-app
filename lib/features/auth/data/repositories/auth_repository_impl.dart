import 'package:e_commerce_app/features/auth/data/data_sources/check_is_email_verified_service.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/log_out_service.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/login_service.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/register_service.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/send_verification_service.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/verify_email_service.dart';
import 'package:e_commerce_app/features/auth/data/models/log_out_response_model.dart';
import 'package:e_commerce_app/features/auth/data/models/login_response_model.dart';
import 'package:e_commerce_app/features/auth/data/models/verify_email_response_model.dart';
import 'package:e_commerce_app/features/auth/data/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LogOutService logOutService;
  final LoginService loginService;
  final RegisterService registerService;
  final VerifyEmailService verifyEmailService;
  final CheckIsEmailVerifiedService checkIsEmailVerifiedService;
  final SendVerificationService sendVerificationService;
  AuthRepositoryImpl({
    required this.logOutService,
    required this.loginService,
    required this.registerService,
    required this.verifyEmailService,
    required this.checkIsEmailVerifiedService,
    required this.sendVerificationService,
  });

  @override
  Future<LogOutResponseModel> logOut() async {
    return await logOutService.logOut();
  }

  @override
  Future<VerifyEmailResponseModel> verifyEmail(
      {required String email, required String token}) async {
    return await verifyEmailService.verifyEmail(email: email, token: token);
  }

  @override
  Future<LoginResponseModel> verifyLogin(
      {required Map<String, dynamic> jsonData}) async {
    return await loginService.verifyLogin(jsonData: jsonData);
  }

  @override
  Future<void> createAccount(
      {required Map<String, dynamic> jsonData}) async {
    return await registerService.createAccount(jsonData: jsonData);
  }

  @override
  Future<bool> sendVerification({required String email}) async {
    return await sendVerificationService.sendVerification(email: email);
  }

  @override
  Future<bool> checkIsEmailVerified({required String email}) async {
    return await checkIsEmailVerifiedService.isEmailVerified(email: email);
  }
}
