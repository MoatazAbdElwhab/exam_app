// core/services/local_storage.dart
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalStorage {
  static const String emailKey = "email";
  static const String passwordKey = "password";
  static const String rememberMeKey = "remember_me";

  static late SharedPreferences _sharedPreferences;

  /// Initialize SharedPreferences
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Save data in SharedPreferences
  static Future<void> cacheData(String key, dynamic value) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    } else if (value is List<String>) {
      await _sharedPreferences.setStringList(key, value);
    }
  }

  /// Retrieve data from SharedPreferences
  static dynamic getCachedData(String key) {
    return _sharedPreferences.get(key);
  }

  /// Remove specific data
  static Future<void> removeData(String key) async {
    await _sharedPreferences.remove(key);
  }

  /// Save login credentials (email & password) if "Remember Me" is checked
  static Future<void> saveLoginCredentials(String email, String password, bool rememberMe) async {
    await cacheData(rememberMeKey, rememberMe);
    if (rememberMe) {
      await cacheData(emailKey, email);
      await cacheData(passwordKey, password);
    } else {
      await removeData(emailKey);
      await removeData(passwordKey);
    }
  }

  /// Load saved login credentials
  static Future<Map<String, dynamic>> getLoginCredentials() async {
    return {
      "email": getCachedData(emailKey) ?? "",
      "password": getCachedData(passwordKey) ?? "",
      "rememberMe": getCachedData(rememberMeKey) ?? false,
    };
  }
}
