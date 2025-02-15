// core/app_data/local_storage/local_storage_client.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../error_handling/exceptions/local_storage_exception.dart';

/// Storage Keys
const String tokenKey = 'token';

@LazySingleton()
class LocalStorageClient {
  final SharedPreferences sharedPreferences;
  final FlutterSecureStorage secureStorage;

  LocalStorageClient(this.sharedPreferences, this.secureStorage);

  /// Save non-secure data
  Future<void> saveData(String key, String value) async {
    try {
      await sharedPreferences.setString(key, value);
    } catch (e) {
      throw LocalStorageException('Failed to save data: ${e.toString()}');
    }
  }

  /// Retrieve non-secure data
  Future<String?> getData(String key) async {
    try {
      return sharedPreferences.getString(key);
    } catch (e) {
      throw LocalStorageException('Failed to get data: ${e.toString()}');
    }
  }

  /// Delete non-secure data
  Future<void> deleteData(String key) async {
    try {
      await sharedPreferences.remove(key);
    } catch (e) {
      throw LocalStorageException('Failed to delete data: ${e.toString()}');
    }
  }

  /// Save secured data
  Future<void> saveSecuredData(String key, String value) async {
    try {
      await secureStorage.write(key: key, value: value);
    } catch (e) {
      throw LocalStorageException('Failed to save secured data: ${e.toString()}');
    }
  }

  /// Retrieve secured data
  Future<String?> getSecuredData(String key) async {
    try {
      return await secureStorage.read(key: key);
    } catch (e) {
      throw LocalStorageException('Failed to get secured data: ${e.toString()}');
    }
  }

  /// Delete secured data
  Future<void> deleteSecuredData(String key) async {
    try {
      await secureStorage.delete(key: key);
    } catch (e) {
      throw LocalStorageException('Failed to delete secured data: ${e.toString()}');
    }
  }
}
