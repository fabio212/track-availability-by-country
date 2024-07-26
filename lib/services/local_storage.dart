import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  void add(String key, String value) async {
    await _initLocalStorage().write(key: key, value: value);
  }

  void delete(String key) async {
    await _initLocalStorage().delete(key: key);
  }

  Future<String> read(String key) async {
    String? value = await (_initLocalStorage()).read(key: key);
    return value ?? '';
  }

  FlutterSecureStorage _initLocalStorage() {
    return const FlutterSecureStorage();
  }
}
