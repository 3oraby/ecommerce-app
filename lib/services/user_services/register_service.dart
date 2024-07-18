import 'package:e_commerce_app/helpers/api.dart';

class RegisterService {
  Future<bool> createAccount({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String imageUrl,
  }) async {
    try {
      await Api().post(
        url: "https://student.valuxapps.com/api/register",
        jsonData: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
          "image": imageUrl,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
