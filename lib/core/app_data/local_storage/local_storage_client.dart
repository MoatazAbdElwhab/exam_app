// core/app_data/local_storage/local_storage_client.dart
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../error_handling/exceptions/local_storage_exception.dart';

/// Storage Keys
const String tokenKey = 'token';

@LazySingleton()
class LocalStorageClient {
  final SharedPreferences sharedPreferences;
  final FlutterSecureStorage secureStorage;
  final Logger _logger = Logger();

  LocalStorageClient(this.sharedPreferences, this.secureStorage);

  /// Save non-secure data
  Future<void> saveData<T>(String key, T value) async {
    try {
      if (value is String) {
        await sharedPreferences.setString(key, value);
      } else if (value is int) {
        await sharedPreferences.setInt(key, value);
      } else if (value is bool) {
        await sharedPreferences.setBool(key, value);
      } else if (value is double) {
        await sharedPreferences.setDouble(key, value);
      } else {
        throw LocalStorageException('Unsupported data type: ${T.toString()}');
      }
    } catch (e) {
      _logger.e('Failed to save data: ${e.toString()}');
      throw LocalStorageException('Failed to save data: ${e.toString()}');
    }
  }

  /// Retrieve non-secure data
  Future<T?> getData<T>(String key) async {
    try {
      if (T == String) {
        return sharedPreferences.getString(key) as T?;
      } else if (T == int) {
        return sharedPreferences.getInt(key) as T?;
      } else if (T == bool) {
        return sharedPreferences.getBool(key) as T?;
      } else if (T == double) {
        return sharedPreferences.getDouble(key) as T?;
      } else {
        throw LocalStorageException('Unsupported data type: ${T.toString()}');
      }
    } catch (e) {
      _logger.e('Failed to get data: ${e.toString()}');
      throw LocalStorageException('Failed to get data: ${e.toString()}');
    }
  }

  /// Delete non-secure data
  Future<void> deleteData(String key) async {
    try {
      await sharedPreferences.remove(key);
    } catch (e) {
      _logger.e('Failed to delete data: ${e.toString()}');
      throw LocalStorageException('Failed to delete data: ${e.toString()}');
    }
  }

  /// Save secured data
  Future<void> saveSecuredData<T>(String key, T value) async {
    try {
      final String serializedValue;
      if (value is String) {
        serializedValue = value;
      } else {
        serializedValue = jsonEncode(value);
      }
      await secureStorage.write(key: key, value: serializedValue);
    } catch (e) {
      _logger.e('Failed to save secured data: ${e.toString()}');
      throw LocalStorageException('Failed to save secured data: ${e.toString()}');
    }
  }

  /// Retrieve secured data
  Future<T?> getSecuredData<T>(String key) async {
    try {
      final String? serializedValue = await secureStorage.read(key: key);
      if (serializedValue == null) return null;
      if (T == String) {
        return serializedValue as T;
      } else {
        return jsonDecode(serializedValue) as T;
      }
    } catch (e) {
      _logger.e('Failed to get secured data: ${e.toString()}');
      throw LocalStorageException('Failed to get secured data: ${e.toString()}');
    }
  }

  /// Delete secured data
  Future<void> deleteSecuredData(String key) async {
    try {
      await secureStorage.delete(key: key);
    } catch (e) {
      _logger.e('Failed to delete secured data: ${e.toString()}');
      throw LocalStorageException('Failed to delete secured data: ${e.toString()}');
    }
  }

  /// Clear all data
  Future<void> clearAllData() async {
    try {
      await sharedPreferences.clear();
      await secureStorage.deleteAll();
    } catch (e) {
      _logger.e('Failed to clear all data: ${e.toString()}');
      throw LocalStorageException('Failed to clear all data: ${e.toString()}');
    }
  }
}