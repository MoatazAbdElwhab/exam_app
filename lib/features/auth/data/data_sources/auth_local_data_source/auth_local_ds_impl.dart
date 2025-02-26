import 'dart:convert';
import 'package:exam_app/core/logger/app_logger.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/app_data/local_storage/local_storage_client.dart';
import 'auth_local_ds_interface.dart';

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
    await _localStorageClient.secureStorage.delete(key: 'token');
  }

  @override
  Future<void> cacheUserProfileInfo(Map<String, dynamic> userInfo) async {
    final jsonString = json.encode(userInfo);
    await _localStorageClient.saveData('userInfo', jsonString);
  }

  @override
  Map<String, dynamic>? getCachedUserInfo() {
    final jsonString = _localStorageClient.getData('userInfo');
    if (jsonString != null) {
      Log.i('got user local info ${json.decode(jsonString)}');
      return json.decode(jsonString);
    } else {
      Log.i('failed to get user local info');
      return null;
    }
  }

  @override
  Future<void> deleteUser() async {
    await _localStorageClient.deleteData('userInfo');
    await _localStorageClient.deleteSecuredData('token');
  }

  @override
  Future<void> removeCachedUserProfileInfo() async {
    await _localStorageClient.deleteData('userInfo');
  }

  @override
  Future<void> cacheRememberMe(bool rememberMe) async {
    await _localStorageClient.saveRememberMe(rememberMe);
  }

  @override
  bool? getRememberMe() {
    return _localStorageClient.getRememberMe();
  }

  @override
  Future<void> deleteRememberMe() async {
    await _localStorageClient.deleteData('rememberUser');
  }
}
