import 'dart:ffi';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton()
class LocalStorageClient {
  SharedPreferences sharedPreferences;
  FlutterSecureStorage storage;

  LocalStorageClient({
    required this.sharedPreferences,
    required this.storage,
  });

  Future<bool> saveData(String key, String value) {
    return sharedPreferences.setString(key, value);
  }

  Future<String?> getData(String key) async {
    return sharedPreferences.getString(key);
  }

  Future<void> saveSecuredData(String key, String value) {
    return storage.write(key: key, value: value);
  }

  Future<String?> getSecuredData(String key) {
    return storage.read(key: key);
  }
}

