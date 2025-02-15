import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../error_handling/exceptions/api_exception.dart';
import '../local_storage/local_storage_client.dart';
import 'api_client.dart';

@Injectable(as: ApiClient)
class DioApiClient implements ApiClient {
  final Dio _dio;
  final LocalStorageClient localStorage;

  DioApiClient(this.localStorage, {String? baseUrl})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl ?? 'https://exam.elevateegy.com/api/v1/',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            responseType: ResponseType.json,
          ),
        );

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    try {
      await checkToken(requiresToken);
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    try {
      await checkToken(requiresToken);
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    try {
      await checkToken(requiresToken);
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    await checkToken(requiresToken);
    try {
      final response = await _dio.delete(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<Map?> checkToken(bool requiresToken) async {
    try {
      if (requiresToken) {
        final token = await localStorage.getSecuredData('token');
        if (token != null) {
          _dio.options.headers.addAll({'token': token});
        } else {
          throw ('error getting user token .. token = null');
        }
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw ApiException(message: 'Connection timeout');
      case DioExceptionType.badResponse:
        throw ApiException(
          message: 'Server error',
          statusCode: error.response?.statusCode,
          response: error.response?.data,
        );
      case DioExceptionType.cancel:
        throw ApiException(message: 'Request cancelled');
      default:
        throw ApiException(message: 'Network error occurred');
    }
  }
}
