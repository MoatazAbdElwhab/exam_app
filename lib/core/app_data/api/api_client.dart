// core/app_data/api/api_client.dart
abstract class ApiClient {
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  });

  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  });

  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  });

  Future<T> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  });

  Future<T> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  });
}
