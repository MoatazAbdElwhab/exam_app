import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../../../../core/app_data/local_storage/local_storage_client.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  Future<String?> getCachedToken();
  Future<void> removeToken();
  Future<void> cacheUserInfo(Map<String, dynamic> userInfo);
  Future<Map<String, dynamic>?> getCachedUserInfo();
  Future<void> removeUserInfo();
}

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorageClient _localStorageClient;

  AuthLocalDataSourceImpl(this._localStorageClient);

  @override
  Future<void> cacheToken(String token) async {
    await _localStorageClient.saveSecuredData('token', token);
  }

  @override
  Future<String?> getCachedToken() async {
    return await _localStorageClient.getSecuredData('token');
  }

  @override
  Future<void> removeToken() async {
    await _localStorageClient.storage.delete(key: 'token');
  }

  @override
  Future<void> cacheUserInfo(Map<String, dynamic> userInfo) async {
    final jsonString = json.encode(userInfo);
    await _localStorageClient.saveData('userInfo', jsonString);
  }

  @override
  Future<Map<String, dynamic>?> getCachedUserInfo() async {
    final jsonString = await _localStorageClient.getData('userInfo');
    if (jsonString != null) {
      return json.decode(jsonString);
    }
    return null;
  }

  @override
  Future<void> removeUserInfo() async {
    await _localStorageClient.sharedPreferences.remove('userInfo');
  }
}