import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageSingleton {
  FlutterSecureStorageSingleton._privateConstructor();
  static final FlutterSecureStorageSingleton instance = 
      FlutterSecureStorageSingleton._privateConstructor();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> setString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getString(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<bool> containsKey(String key) async {
    return await _secureStorage.containsKey(key: key);
  }

  Future<void> clear() async {
    await _secureStorage.deleteAll();
  }

  Future<Map<String, String>> getAll() async {
    return await _secureStorage.readAll();
  }
}
