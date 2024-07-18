import 'package:e_commerce_app/helpers/api.dart';

class LoginService {
  Future<bool> verifyLogin({
    required String email,
    required String password,
  }) async {
    try {
      // Make the API call
      await Api().post(
        url: "https://student.valuxapps.com/api/login",
        jsonData: {
          'email': email,
          'password': password,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
