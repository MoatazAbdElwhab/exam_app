import 'dart:ffi';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../error_handling/exceptions/local_storage_exception.dart';

/// keys
// 'token' => secure

@LazySingleton()
class LocalStorageClient {
  SharedPreferences sharedPreferences;
  FlutterSecureStorage secureStorage;

  LocalStorageClient(
    this.sharedPreferences,
    this.secureStorage,
  );

  Future<void> saveData(String key, String value) async {
    try {
      await sharedPreferences.setString(key, value);
    } catch (e) {
      throw LocalStorageException('Failed to save data: ${e.toString()}');
    }
  }

  Future<String?> getData(String key) async {
    try {
     return sharedPreferences.getString(key,);
    } catch (e) {
      throw LocalStorageException('Failed to get data: ${e.toString()}');

    }
  }

  Future<void> saveSecuredData(String key, String value) async {
    try {
      return await secureStorage.write(key: key, value: value);
    }catch (e){
      throw LocalStorageException('Failed to save data: ${e.toString()}');
    }
  }

  Future<String?> getSecuredData(String key) async {
    try {
      return await secureStorage.read(key: key);
    }catch (e){
      throw LocalStorageException('Failed to get data: ${e.toString()}');
    }
  }

  Future<void>? deleteSecuredData(String key, String value) async {
    try{
      return await secureStorage.delete(key: key);
    }catch(e){
      throw LocalStorageException('Failed to delete data: ${e.toString()}');
    }
  }
}
