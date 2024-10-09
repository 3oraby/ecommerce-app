import 'package:local_auth/local_auth.dart';

class FingerPrintService {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> isFingerPrintEnabledForDevice() async {
    return await _localAuthentication.canCheckBiometrics;
  }

  Future<bool> isAuth(String reason) async {
    return await _localAuthentication.authenticate(
      localizedReason: reason,
      options: const AuthenticationOptions(biometricOnly: true),
    );
  }
}
