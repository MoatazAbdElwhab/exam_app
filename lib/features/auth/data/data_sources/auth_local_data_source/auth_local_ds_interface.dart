abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  Future<String?> getCachedToken();
  Future<void> removeToken();
  Future<void> cacheUserProfileInfo(Map<String, dynamic> userInfo);
  Future<void> removeCachedUserProfileInfo();
  Map<String, dynamic>? getCachedUserInfo();
  Future<void> deleteUser();
  Future<void> cacheRememberMe(bool rememberMe);
  bool? getRememberMe();
  Future<void> deleteRememberMe();
}